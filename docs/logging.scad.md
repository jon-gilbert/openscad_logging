# LibFile: logging.scad

Logging routines for emitting simple and consistent messages into OpenSCAD's console.

To use, add the following lines to the beginning of your file:

    include <logging.scad>

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
    - [`log_info()`](#functionmodule-log_info)
    - [`log_warning()`](#functionmodule-log_warning)
    - [`log_error()`](#functionmodule-log_error)
    - [`log_fatal()`](#functionmodule-log_fatal)
    - [`logger()`](#functionmodule-logger)
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


### Function/Module: log\_debug()

**Usage:** as a module

- log\_debug(msg);

**Usage:** as a function

- \_ = log\_debug(msg);

**Description:** 

Given a log message as either a single string or list, emit a log message prefixed with "DEBUG"
if the global `LOG_LEVEL` is at or lower than `LOG_DEBUG`.

When invoked as a module, `log_debug()` produces no model or element for drawing.

When invoked as a function, `log_debug()` returns undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Todo:** 

- There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error.

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

### Function/Module: log\_info()

**Usage:** as a module

- log\_info(msg);

**Usage:** as a function

- \_ = log\_info(msg);

**Description:** 

Given a log message as either a single string or list, emit a log message prefixed with "INFO"
if the global `LOG_LEVEL` is at or lower than `LOG_INFO`.

When invoked as a module, `log_info()` produces no model or element for drawing.

When invoked as a function, `log_info()` returns undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Todo:** 

- There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error.

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

### Function/Module: log\_warning()

**Usage:** as a module

- log\_warning(msg);

**Usage:** as a function

- \_ = log\_warning(msg);

**Description:** 

Given a log message as either a single string or list, emit a log message prefixed with "WARNING"
if the global `LOG_LEVEL` is at or lower than `LOG_WARNING`.

When invoked as a module, `log_warning()` produces no model or element for drawing.

When invoked as a function, `log_warning()` returns undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Todo:** 

- There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error.

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

### Function/Module: log\_error()

**Usage:** as a module

- log\_error(msg);

**Usage:** as a function

- \_ = log\_error(msg);

**Description:** 

Given a log message as either a single string or list, emit a log message prefixed with "ERROR"
if the global `LOG_LEVEL` is at or lower than `LOG_ERROR`.

When invoked as a module, `log_error()` produces no model or element for drawing.

When invoked as a function, `log_error()` returns undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Todo:** 

- There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error.

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

### Function/Module: log\_fatal()

**Usage:** as a module

- log\_fatal(msg);

**Usage:** as a function

- \_ = log\_fatal(msg);

**Description:** 

Given a log message as either a single string or list, call `assert()` on a `false` value to
emit a log message prefixed with "FATAL". `log_fatal()` is invokable regardless of the
global `LOG_LEVEL` setting.

When invoked as a module, `log_fatal()` halts execution of the .scad file..

When invoked as a function, `log_fatal()` halts execution of the .scad file..

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.

**Todo:** 

- There's *gotta* be a way to call functions within functions that don't return anything not be a syntax error.

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

When invoked as a function, `logger()` returns undef.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`msg`                | The message to emit. `msg` can be either a literal string, or a list of elements.
`msg_level`          | The logging level *of the message*.

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

