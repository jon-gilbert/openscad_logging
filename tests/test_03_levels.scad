
include <logging.scad>

/*
module test_level_undef() {
    assert(LOG_LEVEL == false);
    d = log_debug("debug");
    i = log_info("info");
    w = log_warning("warning");
    e = log_error("error");
    //f = log_fatal("fatal");
    echo(d, i, w, e);
    assert(d == undef);
    assert(i == undef);
    assert(w == "warning");
    assert(e == "error");
}
test_level_undef();
*/

/*
module test_level_debug() {
    LOG_LEVEL = LOG_DEBUG;
    echo(LOG_LEVEL);
    m = log_debug("aaa");
    echo(m);
    assert(m == "DEBUG: test_level_debug(): aaa", str("m: ", m));
}
test_level_debug();
*/

