# openscad_logging
Routines for simple and consistent logging to the OpenSCAD console. These are largely modeled after python's `logging` module, but geared towards emitting consistent messaging within the OpenSCAD console.

```openscad
include <openscad_logging/logging.scad>
LOG_LEVEL = LOG_INFO;

log_debug("This is a debugging message, but you won't see it at LOG_INFO level");
log_info("This is an informational message");

```
There's more in-depth examples at https://github.com/jon-gilbert/openscad_logging/wiki/HOWTO, and a full library reference at https://github.com/jon-gilbert/openscad_logging/wiki/logging.scad


# Installing
1. Download the most recent release of `openscad_logging` from https://github.com/jon-gilbert/openscad_logging/releases/latest 
2. unpack the zipfile or tarball. Inside will be a directory, named `openscad_logging-0.8` (where `0.8` is the version of the release). Extract that folder to your OpenSCAD library directory, 
3. Rename that release directory from `openscad_logging-0.8` to just `openscad_logging`

And you're done!

# A Quick Note
A lot of this project might be generously considered "works for me", and I'm entirely not sure what'll happen when you use it for *you*. That's ok! If something doesn't seem to work right, I think a GitHub issue is perhaps the best way to let me know. I'll try to respond as quickly as life permits. 

# Author & License
This library is copyright 2022-2024 Jonathan Gilbert <jong@jong.org>, and released for use under the [MIT License](LICENSE.md).

