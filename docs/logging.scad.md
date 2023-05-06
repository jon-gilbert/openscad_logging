# LibFile: logging.scad

Logging routines for emitting simple and consistent messages into OpenSCAD's console.

To use, add the following lines to the beginning of your file:

    include <logging.scad>


...and then, set a `LOG_LEVEL` variable somewhere within your model file. See the `LOG_LEVEL` definition in
the "Logging Level Constants" section, below.

## Table of Contents

1. [Section: Logging Level Constants](#section-logging-level-constants)
    - [`LOG_LEVEL`](#constant-log_level)
    - [`LOG_DEBUG`](#constant-log_debug)
    - [`LOG_INFO`](#constant-log_info)
    - [`LOG_WARNING`](#constant-log_warning)
    - [`LOG_ERROR`](#constant-log_error)
    - [`LOG_FATAL`](#constant-log_fatal)
    - [`LOG_NAMES`](#constant-log_names)

2. [Section: Logging Functions](#section-logging-functions)
    - [`log_debug()`](#functionmodule-log_debug)
    - [`log_debug_if()`](#functionmodule-log_debug_if)
    - [`log_debug_unless()`](#functionmodule-log_debug_unless)
    - [`log_debug_assign()`](#function-log_debug_assign)
    - [`log_info()`](#functionmodule-log_info)
    - [`log_info_if()`](#functionmodule-log_info_if)
    - [`log_info_unless()`](#functionmodule-log_info_unless)
    - [`log_info_assign()`](#function-log_info_assign)
    - [`log_warning()`](#functionmodule-log_warning)
    - [`log_warning_if()`](#functionmodule-log_warning_if)
    - [`log_warning_unless()`](#functionmodule-log_warning_unless)
    - [`log_warning_assign()`](#function-log_warning_assign)
    - [`log_error()`](#functionmodule-log_error)
    - [`log_error_if()`](#functionmodule-log_error_if)
    - [`log_error_unless()`](#functionmodule-log_error_unless)
    - [`log_error_assign()`](#function-log_error_assign)
    - [`log_fatal()`](#functionmodule-log_fatal)
    - [`log_fatal_if()`](#functionmodule-log_fatal_if)
    - [`log_fatal_unless()`](#functionmodule-log_fatal_unless)

3. [Section: Core Logging Functions](#section-core-logging-functions)
    - [`logger()`](#functionmodule-logger)
    - [`logger_if()`](#functionmodule-logger_if)
    - [`logger_unless()`](#functionmodule-logger_unless)
    - [`logger_assign()`](#function-logger_assign)
    - [`format_log()`](#function-format_log)
    - [`log_match()`](#function-log_match)


## Section: Logging Level Constants


### Constant: LOG\_LEVEL

**Description:** 

The global `LOG_LEVEL`: denotes the logging level for a given .scad file.  **You must
set this constant within your model file somewhere** for logging to take effect. You may only set `LOG_LEVEL` once.

`LOG_LEVEL` may also be set on the command-line with OpenSCAD's `-D` option: `openscad -o out.echo -D"LOG_LEVEL=1" ./file.scad`
will set `LOG_LEVEL` before your script executes. For this, you'll need the numerical value of the log level you want.

**Example 1:** 

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    //
    log_debug("debugging message");   // nothing is emitted to the console
    log_warning("warning message");   // "ECHO: WARNING: warning message" is emitted to the console.

<br clear="all" /><br/>

**Example 2:** declaring `LOG_LEVEL` before logging.scad is included:

    include <logging.scad>
    // in a file that has not yet declared the logging
    // inclusion, the level is set to LOG_WARNING's
    // numerical value:
    LOG_LEVEL = 3;
    // ...some lines of code later:
    include <logging.scad>
    log_debug("debugging message");   // nothing is emitted to the console
    log_warning("warning message");   // "ECHO: WARNING: warning message" is emitted to the console.

<br clear="all" /><br/>

**See Also:** [LOG\_FATAL](#constant-log_fatal), [LOG\_ERROR](#constant-log_error), [LOG\_WARNING](#constant-log_warning), [LOG\_INFO](#constant-log_info), [LOG\_DEBUG](#constant-log_debug)

---

### Constant: LOG\_DEBUG

**Description:** 

Denotes a logging level. By declaring `LOG_DEBUG` as your global `LOG_LEVEL`, the
only logging messages that will be emitted to the console will be those of
a DEBUG level or lower. That list of levels is
`LOG_DEBUG`, `LOG_INFO`, `LOG_WARNING`, `LOG_ERROR`, and `LOG_FATAL`.

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_info()](#functionmodule-log_info), [log\_warning()](#functionmodule-log_warning), [log\_error()](#functionmodule-log_error), [log\_fatal()](#functionmodule-log_fatal)

---

### Constant: LOG\_INFO

**Description:** 

Denotes a logging level. By declaring `LOG_INFO` as your global `LOG_LEVEL`, the
only logging messages that will be emitted to the console will be those of
a INFO level or lower. That list of levels is
`LOG_INFO`, `LOG_WARNING`, `LOG_ERROR`, and `LOG_FATAL`.

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_info()](#functionmodule-log_info), [log\_warning()](#functionmodule-log_warning), [log\_error()](#functionmodule-log_error), [log\_fatal()](#functionmodule-log_fatal)

---

### Constant: LOG\_WARNING

**Description:** 

Denotes a logging level. By declaring `LOG_WARNING` as your global `LOG_LEVEL`, the
only logging messages that will be emitted to the console will be those of
a WARNING level or lower. That list of levels is
`LOG_WARNING`, `LOG_ERROR`, and `LOG_FATAL`.

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_info()](#functionmodule-log_info), [log\_warning()](#functionmodule-log_warning), [log\_error()](#functionmodule-log_error), [log\_fatal()](#functionmodule-log_fatal)

---

### Constant: LOG\_ERROR

**Description:** 

Denotes a logging level. By declaring `LOG_ERROR` as your global `LOG_LEVEL`, the
only logging messages that will be emitted to the console will be those of
a ERROR level or lower. That list of levels is
`LOG_ERROR` and `LOG_FATAL`.

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_info()](#functionmodule-log_info), [log\_warning()](#functionmodule-log_warning), [log\_error()](#functionmodule-log_error), [log\_fatal()](#functionmodule-log_fatal)

---

### Constant: LOG\_FATAL

**Description:** 

Denotes a logging level. By declaring `LOG_FATAL` as your global `LOG_LEVEL`, the
only logging messages that will be emitted to the console will be those of
a FATAL level. This is the highest of the logging levels.

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_info()](#functionmodule-log_info), [log\_warning()](#functionmodule-log_warning), [log\_error()](#functionmodule-log_error), [log\_fatal()](#functionmodule-log_fatal)

---

### Constant: LOG\_NAMES

**Description:** 

A list of the names of the logging levels. This is provided for a simple lookup
and labeling of the `LOG_*` level constants above when the log message is formatted.
The element's positions must correspond to the log level's numerical constant value.

---

## Section: Logging Functions

In general, there are a common collection of logging functions and modules for each log level specified in `LOG_NAMES`,
all doing approximately the same thing. Each function and module has a more detailed write-up in this section
below, but at a high level each logging level (WARNING, ERROR, et al) has one the following:

* a basic logging method and function (eg, `log_debug()`)
* a conditional "log this message if the test is true" method and function (eg, `log_info_if()`)
* a conditional "log this message *unless* the test is true" method and function (eg, `log_warning_unless()`)
* an assignment logging function, that logs and assigns in one step (eg, `log_error_assign()`)

### Function/Module: log\_debug()

**Usage:** as a module

- log\_debug(msg);

**Usage:** as a function

- \_ = log\_debug(msg);

**Description:** 

Given a log message as either a single string or list, emit a log message prefixed with "DEBUG"
if the global `LOG_LEVEL` is at or lower than `LOG_DEBUG`.

When invoked as a module, `log_debug()` produces no model or element for drawing.

When invoked as a function, `log_debug()` returns `msg` if it should have emitted to the console, or undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_debug("log message");
    // emits to the console:  ECHO: "DEBUG: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_debug(["message with additional info:", 1]);
    // emits to the console:  ECHO: "DEBUG: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    function myfunc(v) = let( _ = log_debug("log message") ) v + 1;
    new_v = myfunc(1);
    // emits to the console:  ECHO: "DEBUG: log message"

<br clear="all" /><br/>

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_info()](#functionmodule-log_info), [log\_warning()](#functionmodule-log_warning), [log\_error()](#functionmodule-log_error), [log\_fatal()](#functionmodule-log_fatal)

---

### Function/Module: log\_debug\_if()

**Usage:** as a module

- log\_debug\_if(test, msg);

**Usage:** as a function:

- bool = log\_debug\_if(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "DEBUG" if the `test` evaluates to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_DEBUG`.

When invoked as a module, `log_debug_if()` does not produce a model or element for drawing.

When invoked as a function, `log_debug_if()` returns the evaluated value of `test`.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable expression, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_debug_if(true, "log message");
    // emits to the console:  ECHO: "DEBUG: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_debug_if(1 > 0, ["message with additional info:", 1]);
    // emits to the console:  ECHO: "DEBUG: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_debug_if(0 > 1, ["message with additional info:", 1]);
    // nothing is emitted to the console

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    v = log_debug_if(1 > 0, "log message");
    // emits to the console: ECHO: "DEBUG: log message"
    // v == true

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    v = log_debug_if(0 > 1, "log message");
    // nothing is emitted to the console
    // v == false

<br clear="all" /><br/>

---

### Function/Module: log\_debug\_unless()

**Usage:** as a module

- log\_debug\_unless(test, msg);

**Usage:** as a function:

- bool = log\_debug\_unless(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "DEBUG" if the `test` does not evaluate to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_DEBUG`.

When invoked as a module, `log_debug_unless()` does not produce a model or element for drawing.

When invoked as a function, `log_debug_unless()` returns the evaluated value of `test`.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable expression, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_debug_unless(false, "log message");
    // emits to the console:  ECHO: "DEBUG: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_debug_unless(1 < 0, ["message with additional info:", 1]);
    // emits to the console:  ECHO: "DEBUG: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to false:

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_debug_unless(0 < 1, ["message with additional info:", 1]);
    // nothing is emitted to the console

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    v = log_debug_unless(1 < 0, "log message");
    // emits to the console: ECHO: "DEBUG: log message"
    // v == false

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to false:

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    v = log_debug_unless(0 < 1, "log message");
    // nothing is emitted to the console
    // v == true

<br clear="all" /><br/>

---

### Function: log\_debug\_assign()

**Usage:** 

- val = log\_debug\_assign(val);
- val = log\_debug\_assign(val, &lt;msg&gt;);

**Description:** 

Given a value, `log_debug_assign()` will log that the value `val` is being
assigned, and then will return the value `val`. If an optional log message
`msg` is specified, that message will be log instead.

The log message is emitted according to the logging level as is normally done
via `logger()`: if `LOG_LEVEL` isn't set to at least `LOG_DEBUG`, the message
will not be emitted.

The given value `val` is returned regardless of whether a log message was emitted.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`val`                | An arbitrary value.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements. If unspecified, a placeholder message will be used.


There is no corresponding `log_debug_assign()` module.

**Example 1:** logging assignment information at a "debug" level: the variable `x` is assigned the value of `1`, and there is a log message saying this was done.

    include <logging.scad>
    LOG_LEVEL=LOG_DEBUG;
    x = log_debug_assign(1, "assigning 1 to x");
    // emits to the console: ECHO: "DEBUG: assigning 1 to x"
    // x == 1

<br clear="all" /><br/>

**Example 2:** logging at an "info" level: the variable `x` is assigned the value of `1`, but because `LOG_LEVEL` is set higher than "debug", no message is emitted to the console log.

    include <logging.scad>
    LOG_LEVEL=LOG_INFO;
    x = log_debug_assign(1, "assigning 1 to x");
    // nothing is emitted to the console
    // x == 1

<br clear="all" /><br/>

---

### Function/Module: log\_info()

**Usage:** as a module

- log\_info(msg);

**Usage:** as a function

- \_ = log\_info(msg);

**Description:** 

Given a log message as either a single string or list, emit a log message prefixed with "INFO"
if the global `LOG_LEVEL` is at or lower than `LOG_INFO`.

When invoked as a module, `log_info()` produces no model or element for drawing.

When invoked as a function, `log_info()` returns `msg` if it should have emitted to the console, or undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_INFO;
    log_info("log message");
    // emits to the console:  ECHO: "INFO: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_INFO;
    log_info(["message with additional info:", 1]);
    // emits to the console:  ECHO: "INFO: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_INFO;
    function myfunc(v) = let( _ = log_info("log message") ) v + 1;
    new_v = myfunc(1);
    // emits to the console:  ECHO: "INFO: log message"

<br clear="all" /><br/>

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_warning()](#functionmodule-log_warning), [log\_error()](#functionmodule-log_error), [log\_fatal()](#functionmodule-log_fatal)

---

### Function/Module: log\_info\_if()

**Usage:** as a module

- log\_info\_if(test, msg);

**Usage:** as a function:

- bool = log\_info\_if(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "INFO" if the `test` evaluates to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_INFO`.

When invoked as a module, `log_info_if()` does not produce no model or element for drawing.

When invoked as a function, `log_info_if()` returns the evaluated value of `test`.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable expression, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_INFO;
    log_info_if(true, "log message");
    // emits to the console:  ECHO: "INFO: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = INFO;
    log_info_if(1 > 0, ["message with additional info:", 1]);
    // emits to the console:  ECHO: "INFO: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_info_if(0 > 1, ["message with additional info:", 1]);
    // nothing is emitted to the console

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    v = log_info_if(1 > 0, "log message");
    // emits to the console: ECHO: "INFO: log message"
    // v == true

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    v = log_info_if(0 > 1, "log message");
    // nothing is emitted to the console
    // v == false

<br clear="all" /><br/>

---

### Function/Module: log\_info\_unless()

**Usage:** as a module

- log\_info\_unless(test, msg);

**Usage:** as a function:

- bool = log\_info\_unless(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "INFO" if the `test` does not evaluate to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_INFO`.

When invoked as a module, `log_info_unless()` does not produce a model or element for drawing.

When invoked as a function, `log_info_unless()` returns the evaluated value of `test`.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable express, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_INFO;
    log_info_unless(false, "log message");
    // emits to the console:  ECHO: "INFO: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = INFO;
    log_info_unless(1 < 0, ["message with additional info:", 1]);
    // emits to the console:  ECHO: "INFO: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to false

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    log_info_unless(0 < 1, ["message with additional info:", 1]);
    // nothing is emitted to the console

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    v = log_info_unless(1 < 0, "log message");
    // emits to the console: ECHO: "INFO: log message"
    // v == false

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to false

    include <logging.scad>
    LOG_LEVEL = LOG_DEBUG;
    v = log_info_unless(0 < 1, "log message");
    // nothing is emitted to the console
    // v == true

<br clear="all" /><br/>

---

### Function: log\_info\_assign()

**Usage:** 

- val = log\_info\_assign(val);
- val = log\_info\_assign(val, &lt;msg&gt;);

**Description:** 

Given a value, `log_info_assign()` will log that the value `val` is being
assigned, and then will return the value `val`. If an optional log message
`msg` is specified, that message will be log instead.

The log message is emitted according to the logging level as is normally done
via `logger()`: if `LOG_LEVEL` isn't set to at least `LOG_INFO`, the message
will not be emitted.

The given value `val` is returned regardless of whether a log message was emitted.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`val`                | An arbitrary value.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements. If unspecified, a placeholder message will be used.


There is no corresponding `log_info_assign()` module.

**Example 1:** logging assignment information at a "info" level: the variable `x` is assigned the value of `1`, and there is a log message saying this was done.

    include <logging.scad>
    LOG_LEVEL=LOG_INFO;
    x = log_info_assign(1, "assigning 1 to x");
    // emits to the console: ECHO: "INFO: assigning 1 to x"
    // x == 1

<br clear="all" /><br/>

**Example 2:** logging at an "warning" level: the variable `x` is assigned the value of `1`, but because `LOG_LEVEL` is set higher than "info", no message is emitted to the console log.

    include <logging.scad>
    LOG_LEVEL=LOG_WARNING;
    x = log_info_assign(1, "assigning 1 to x");
    // nothing is emitted to the console
    // x == 1

<br clear="all" /><br/>

---

### Function/Module: log\_warning()

**Usage:** as a module

- log\_warning(msg);

**Usage:** as a function

- \_ = log\_warning(msg);

**Description:** 

Given a log message as either a single string or list, emit a log message prefixed with "WARNING"
if the global `LOG_LEVEL` is at or lower than `LOG_WARNING`.

When invoked as a module, `log_warning()` produces no model or element for drawing.

When invoked as a function, `log_warning()` returns `msg` if it should have emitted to the console, or undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    log_warning("log message");
    // emits to the console:  ECHO: "WARNING: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    log_warning(["message with additional info:", 1]);
    // emits to the console:  ECHO: "WARNING: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    function myfunc(v) = let( _ = log_warning("log message") ) v + 1;
    new_v = myfunc(1);
    // emits to the console:  ECHO: "WARNING: log message"

<br clear="all" /><br/>

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_info()](#functionmodule-log_info), [log\_error()](#functionmodule-log_error), [log\_fatal()](#functionmodule-log_fatal)

---

### Function/Module: log\_warning\_if()

**Usage:** as a module

- log\_warning\_if(test, msg);

**Usage:** as a function:

- bool = log\_warning\_if(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "WARNING" if the `test` evaluates to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_WARNING`.

When invoked as a module, `log_warning_if()` does not produce a model or element for drawing.

When invoked as a function, `log_warning_if()` returns the evaluated value of `test`.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable expression, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    log_warning_if(true, "log message");
    // emits to the console:  ECHO: "WARNING: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    log_warning_if(1 > 0, ["message with additional info:", 1]);
    // emits to the console:  ECHO: "WARNING: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    log_warning_if(0 > 1, ["message with additional info:", 1]);
    // nothing is emitted to the console

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    v = log_warning_if(1 > 0, "log message");
    // emits to the console: ECHO: "WARNING: log message"
    // v == true

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    v = log_warning_if(0 > 1, "log message");
    // nothing is emitted to the console
    // v == false

<br clear="all" /><br/>

---

### Function/Module: log\_warning\_unless()

**Usage:** as a module

- log\_warning\_unless(test, msg);

**Usage:** as a function:

- bool = log\_warning\_unless(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "WARNING" if the `test` does not evaluate to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_WARNING`.

When invoked as a module, `log_warning_unless()` does not produce a model or element for drawing.

When invoked as a function, `log_warning_unless()` returns the evaluated value of `test`.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable expression, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    log_warning_unless(false, "log message");
    // emits to the console:  ECHO: "WARNING: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    log_warning_unless(1 < 0, ["message with additional info:", 1]);
    // emits to the console:  ECHO: "WARNING: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to false

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    log_warning_unless(0 < 1, ["message with additional info:", 1]);
    // nothing is emitted to the console

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    v = log_warning_unless(1 < 0, "log message");
    // emits to the console: ECHO: "WARNING: log message"
    // v == false

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to false

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    v = log_warning_unless(0 < 1, "log message");
    // nothing is emitted to the console
    // v == true

<br clear="all" /><br/>

---

### Function: log\_warning\_assign()

**Usage:** 

- val = log\_warning\_assign(val);
- val = log\_warning\_assign(val, &lt;msg&gt;);

**Description:** 

Given a value, `log_warning_assign()` will log that the value `val` is being
assigned, and then will return the value `val`. If an optional log message
`msg` is specified, that message will be log instead.

The log message is emitted according to the logging level as is normally done
via `logger()`: if `LOG_LEVEL` isn't set to at least `LOG_WARNING`, the message
will not be emitted.

The given value `val` is returned regardless of whether a log message was emitted.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`val`                | An arbitrary value.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements. If unspecified, a placeholder message will be used.


There is no corresponding `log_warning_assign()` module.

**Example 1:** logging assignment information at a "warning" level: the variable `x` is assigned the value of `1`, and there is a log message saying this was done.

    include <logging.scad>
    LOG_LEVEL=LOG_WARNING;
    x = log_warning_assign(1, "assigning 1 to x");
    // emits to the console: ECHO: "WARNING: assigning 1 to x"
    // x == 1

<br clear="all" /><br/>

**Example 2:** logging at an "error" level: the variable `x` is assigned the value of `1`, but because `LOG_LEVEL` is set higher than "warning", no message is emitted to the console log.

    include <logging.scad>
    LOG_LEVEL=LOG_ERROR;
    x = log_warning_assign(1, "assigning 1 to x");
    // nothing is emitted to the console
    // x == 1

<br clear="all" /><br/>

---

### Function/Module: log\_error()

**Usage:** as a module

- log\_error(msg);

**Usage:** as a function

- \_ = log\_error(msg);

**Description:** 

Given a log message as either a single string or list, emit a log message prefixed with "ERROR"
if the global `LOG_LEVEL` is at or lower than `LOG_ERROR`.

When invoked as a module, `log_error()` produces no model or element for drawing.

When invoked as a function, `log_error()` returns `msg` if it should have emitted to the console, or undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    log_error("log message");
    // emits to the console:  ECHO: "ERROR: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    log_error(["message with additional info:", 1]);
    // emits to the console:  ECHO: "ERROR: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    function myfunc(v) = let( _ = log_error("log message") ) v + 1;
    new_v = myfunc(1);
    // emits to the console:  ECHO: "ERROR: log message"

<br clear="all" /><br/>

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_info()](#functionmodule-log_info), [log\_warning()](#functionmodule-log_warning), [log\_fatal()](#functionmodule-log_fatal)

---

### Function/Module: log\_error\_if()

**Usage:** as a module

- log\_error\_if(test, msg);

**Usage:** as a function:

- bool = log\_error\_if(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "ERROR" if the `test` evaluates to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_ERROR`.

When invoked as a module, `log_error_if()` does not produce a model or element for drawing.

When invoked as a function, `log_error_if()` returns the evaluated value of `test`.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable express, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    log_error_if(true, "log message");
    // emits to the console:  ECHO: "ERROR: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    log_error_if(1 > 0, ["message with additional info:", 1]);
    // emits to the console:  ECHO: "ERROR: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    log_error_if(0 > 1, ["message with additional info:", 1]);
    // nothing is emitted to the console

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    v = log_error_if(1 > 0, "log message");
    // emits to the console: ECHO: "ERROR: log message"
    // v == true

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    v = log_error_if(0 > 1, "log message");
    // nothing is emitted to the console
    // v == false

<br clear="all" /><br/>

---

### Function/Module: log\_error\_unless()

**Usage:** as a module

- log\_error\_unless(test, msg);

**Usage:** as a function:

- bool = log\_error\_unless(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "ERROR" if the `test` does not evaluate to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_ERROR`.

When invoked as a module, `log_error_unless()` does not produce a model or element for drawing.

When invoked as a function, `log_error_unless()` returns the evaluated value of `test`.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable expression, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    log_error_unless(false, "log message");
    // emits to the console:  ECHO: "ERROR: log message"

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    log_error_unless(1 < 0, ["message with additional info:", 1]);
    // emits to the console:  ECHO: "ERROR: message with additional info: 1"

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to false

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    log_error_unless(0 < 1, ["message with additional info:", 1]);
    // nothing is emitted to the console

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    v = log_error_unless(1 < 0, "log message");
    // emits to the console: ECHO: "ERROR: log message"
    // v == false

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to false

    include <logging.scad>
    LOG_LEVEL = LOG_ERROR;
    v = log_error_unless(0 < 1, "log message");
    // nothing is emitted to the console
    // v == true

<br clear="all" /><br/>

---

### Function: log\_error\_assign()

**Usage:** 

- val = log\_error\_assign(val);
- val = log\_error\_assign(val, &lt;msg&gt;);

**Description:** 

Given a value, `log_error_assign()` will log that the value `val` is being
assigned, and then will return the value `val`. If an optional log message
`msg` is specified, that message will be log instead.

The log message is emitted according to the logging level as is normally done
via `logger()`: if `LOG_LEVEL` isn't set to at least `LOG_ERROR`, the message
will not be emitted.

The given value `val` is returned regardless of whether a log message was emitted.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`val`                | An arbitrary value.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements. If unspecified, a placeholder message will be used.


There is no corresponding `log_error_assign()` module.

**Example 1:** logging assignment information at a "error" level: the variable `x` is assigned the value of `1`, and there is a log message saying this was done.

    include <logging.scad>
    LOG_LEVEL=LOG_ERROR;
    x = log_error_assign(1, "assigning 1 to x");
    // emits to the console: ECHO: "ERROR: assigning 1 to x"
    // x == 1

<br clear="all" /><br/>

**Example 2:** logging at an "fatal" level: the variable `x` is assigned the value of `1`, but because `LOG_LEVEL` is set higher than "error", no message is emitted to the console log.

    include <logging.scad>
    LOG_LEVEL=LOG_FATAL;
    x = log_error_assign(1, "assigning 1 to x");
    // nothing is emitted to the console
    // x == 1

<br clear="all" /><br/>

---

### Function/Module: log\_fatal()

**Usage:** as a module

- log\_fatal(msg);

**Usage:** as a function

- \_ = log\_fatal(msg);

**Description:** 

Given a log message as either a single string or list, call `assert()` on a `false` value to
emit a log message prefixed with "FATAL". `log_fatal()` is invokable regardless of the
global `LOG_LEVEL` setting.

When invoked as a module, `log_fatal()` halts execution of the .scad file.

When invoked as a function, `log_fatal()` halts execution of the .scad file.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    log_fatal("log message");
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ...

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    log_fatal(["message with additional info:", 1]);
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: message with addtional info: 1" in file ..., line ...

<br clear="all" /><br/>

**Example 3:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    function myfunc(v) = let( _ = log_fatal("log message") ) v + 1;
    new_v = myfunc(1);
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ...

<br clear="all" /><br/>

**See Also:** [LOG\_LEVEL](#constant-log_level), [log\_debug()](#functionmodule-log_debug), [log\_info()](#functionmodule-log_info), [log\_warning()](#functionmodule-log_warning), [log\_error()](#functionmodule-log_error)

---

### Function/Module: log\_fatal\_if()

**Usage:** as a module

- log\_fatal\_if(test, msg);

**Usage:** as a function:

- bool = log\_fatal\_if(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "FATAL" if the `test` evaluates to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_FATAL`.

When invoked as a module, `log_fatal_if()` halts execution of the .scad file.

When invoked as a function, `log_fatal_if()` halts execution of the .scad file.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable expression, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    log_fatal_if(true, "log message");
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ...

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    log_fatal_if(1 > 0, ["message with additional info:", 1]);
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: message with additional info: 1" in file ..., line ...

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    log_fatal_if(0 > 1, ["message with additional info:", 1]);
    // nothing is emitted to the console, execution of the .scad file is *not* halted.

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    v = log_fatal_if(1 > 0, "log message");
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ...
    // v is not evaluatable, because execution will have been halted

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to true:

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    v = log_fatal_if(0 > 1, "log message");
    // nothing is emitted to the console
    // v == false

<br clear="all" /><br/>

---

### Function/Module: log\_fatal\_unless()

**Usage:** as a module

- log\_fatal\_unless(test, msg);

**Usage:** as a function:

- bool = log\_fatal\_unless(test, msg);

**Description:** 

Given an evaluatable boolean test, and a log message as either a single string or list, emit a
log message prefixed with "FATAL" if the `test` does not evaluate to `true` and if the global
`LOG_LEVEL` is at or lower than `LOG_FATAL`.

When invoked as a module, `log_fatal_unless()` halts execution of the .scad file.

When invoked as a function, `log_fatal_unless()` halts execution of the .scad file.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | An evaluatable expression, or a flat boolean expression. No default.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Example 1:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    log_fatal_unless(false, "log message");
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ...

<br clear="all" /><br/>

**Example 2:** when invoked as a module

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    log_fatal_unless(1 < 0, ["message with additional info:", 1]);
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: message with additional info: 1" in file ..., line ...

<br clear="all" /><br/>

**Example 3:** when invoked as a module and `test` does not evaluate to false

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    log_fatal_unless(0 < 1, ["message with additional info:", 1]);
    // nothing is emitted to the console, execution of the .scad file is *not* halted.

<br clear="all" /><br/>

**Example 4:** when invoked as a function

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    v = log_fatal_unless(1 < 0, "log message");
    // emits to the console:  ERROR: Assertion 'false' failed: "FATAL: log message" in file ..., line ...
    // v is not evaluatable, because execution will have been halted

<br clear="all" /><br/>

**Example 5:** when invoked as a function and `test` does not evaluate to false

    include <logging.scad>
    LOG_LEVEL = LOG_FATAL;
    v = log_fatal_unless(0 < 1, "log message");
    // nothing is emitted to the console
    // v == true

<br clear="all" /><br/>

---

## Section: Core Logging Functions


### Function/Module: logger()

**Usage:** as a module

- logger(msg, msg\_level);

**Usage:** as a function

- \_ = logger(msg, msg\_level);

**Description:** 

A base function and method on which all `log_` functions use.
Given a log message as either a single string or list, emit a log message prefixed with the
level's prefix from `LOG_NAMES` if the `msg_level` is at or lower than `LOG_LEVEL`.

When invoked as a module, `logger()` produces no model or element for drawing.

When invoked as a function, `logger()` returns `msg` if it should have emitted to the console, or undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.
`msg_level`          | The logging level *of the message*.

---

### Function/Module: logger\_if()

**Usage:** as a module

- logger\_if(test, msg, msg\_level);

**Usage:** as a function

- result = logger\_if(test, msg, msg\_level);

**Description:** 

Conditionally emits given `msg` at the log level `msg_level` if given `test` evaluates to `true`.
`test` is expected to be a boolean comparison result, one of either `true` or `false`.
Mnenomic: "If this test is true, log this message."

When invoked as a module, `logger_if()` produces no model or element for drawing.

When invoked as a function, `logger_if()` returns the evaluated value of `test`.
*This is not the same behavior as `logger()`.*

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | A boolean result from an evaluation test.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.
`msg_level`          | The logging level *of the message*.

---

### Function/Module: logger\_unless()

**Usage:** as a module

- logger\_unless(test, msg, msg\_level);

**Usage:** as a function

- result = logger\_unless(test, msg, msg\_level);

**Description:** 

Conditionally emits given `msg` at the log level `msg_level` if given `test` evaluates to `false`.
`test` is expected to be a boolean comparison result, one of either `true` or `false`.
Mnenomic: "Unless this test is true, log this message."

When invoked as a module, `logger_unless()` produces no model or element for drawing.

When invoked as a function, `logger_unless()` returns the evaluated value of `test`.
*This is not the same behavior as `logger()`.*

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`test`               | A boolean result from an evaluation test.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.
`msg_level`          | The logging level *of the message*.

---

### Function: logger\_assign()

**Usage:** 

- val = logger\_assign(val, msg, msg\_level);

**Description:** 

Given a value `val`, a log message `msg`, and a logging level `msg_level`,
emit `msg` at the given `msg_level`, and return `val` as-is.
If `msg` is specified as `undef`, a limited placeholder log message will be
generated, incorporating the `val`'s value.

The log `msg` is emitted according to the logging level as is normally done
via `logger()`. The given value `val` is returned regardless of whether a
log message was emitted.

`val` is not used in evaluating whether `msg` should be emitted.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`val`                | An arbitrary value.
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.
`msg_level`          | The logging level *of the message*.


Because this activity is focused around variable assignment, there is no corresponding
`logger_assign()` module: something is always returned.

---

### Function: format\_log()

**Usage:** 

- string = format\_log(msg, &lt;level=LOG\_LEVEL&gt;);

**Description:** 

Given a list of message elements and optionally a log level, construct and return
a log message suitable for logging to the console. Messages are prefixed with the
string-version of the specified logging level. Messages that are lists are
converted to single strings, with each element joined together with a space (` `).

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

<abbr title="These args must be used by name, ie: name=value">By&nbsp;Name</abbr> | What it does
-------------------- | ------------
`level`              | The logging level at which to create this message. Default: `LOG_LEVEL`.

---

### Function: log\_match()

**Usage:** 

- bool = log\_match(level, &lt;global\_level=LOG\_LEVEL&gt;);

**Description:** 

Given a logging level, and optionally a comparison level, return `true` if
the levels match, and `false` if the levels to not match. Both levels must
be an integer.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`level`              | The level at which to check. No default.

<abbr title="These args must be used by name, ie: name=value">By&nbsp;Name</abbr> | What it does
-------------------- | ------------
`global_level`       | The level to compare at. Default: `LOG_LEVEL`


Evaluation of `LOG_LEVEL` is delayed until only after a `global_level`
isn't available. This is done so that you can still evaluate `log_match()`
comparisons without a globally-set `LOG_LEVEL`.

**Example 1:** 

    include <logging.scad>
    LOG_LEVEL = LOG_WARNING;
    echo(log_match(LOG_DEBUG));
    // emits:  ECHO: false
    echo(log_match(LOG_ERROR));
    // emits:  ECHO: true

<br clear="all" /><br/>

**Example 2:** 

    include <logging.scad>
    echo(log_match(LOG_ERROR, LOG_ERROR));
    // emits:  ECHO: true
    echo(log_match(LOG_DEBUG, LOG_ERROR));
    // emits:  ECHO: false

<br clear="all" /><br/>

---

