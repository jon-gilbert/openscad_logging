
include <507/common/logging.scad>


// NOTE: we set this here in this test file to silence 
// warnings about LOG_LEVEL not being defined. 
// Tests within this file should NOT make calls to log_* 
// that depend on LOG_LEVEL being defined. 
LOG_LEVEL = undef;


module test_format_log() {
    assert(format_log("abcd", LOG_FATAL)   == "FATAL: abcd"  );
    assert(format_log("abcd", LOG_ERROR)   == "ERROR: abcd"  );
    assert(format_log("abcd", LOG_WARNING) == "WARNING: abcd");
    assert(format_log("abcd", LOG_INFO)    == "INFO: abcd");
    assert(format_log("abcd", LOG_DEBUG)   == "DEBUG: abcd"  );

    assert(format_log(["aa", "bb"], LOG_DEBUG)   == "DEBUG: aa bb"  );

    assert(format_log(["aa", [1, 2]], LOG_DEBUG)   == "DEBUG: aa [1, 2]"  );

}
test_format_log();


module test_log_match() {
    assert(log_match(LOG_DEBUG, LOG_DEBUG));
    assert(log_match(LOG_DEBUG, LOG_INFO) == false);
    assert(log_match(LOG_DEBUG, LOG_WARNING) == false);
    assert(log_match(LOG_DEBUG, LOG_ERROR) == false);
    assert(log_match(LOG_DEBUG, LOG_FATAL) == false);

    assert(log_match(LOG_INFO, LOG_DEBUG));
    assert(log_match(LOG_INFO, LOG_INFO));
    assert(log_match(LOG_INFO, LOG_WARNING) == false);
    assert(log_match(LOG_INFO, LOG_ERROR) == false);
    assert(log_match(LOG_INFO, LOG_FATAL) == false);

    assert(log_match(LOG_WARNING, LOG_DEBUG));
    assert(log_match(LOG_WARNING, LOG_INFO));
    assert(log_match(LOG_WARNING, LOG_WARNING));
    assert(log_match(LOG_WARNING, LOG_ERROR) == false);
    assert(log_match(LOG_WARNING, LOG_FATAL) == false);

    assert(log_match(LOG_ERROR, LOG_DEBUG));
    assert(log_match(LOG_ERROR, LOG_INFO));
    assert(log_match(LOG_ERROR, LOG_WARNING));
    assert(log_match(LOG_ERROR, LOG_ERROR));
    assert(log_match(LOG_ERROR, LOG_FATAL) == false);

    assert(log_match(LOG_FATAL, LOG_DEBUG));
    assert(log_match(LOG_FATAL, LOG_INFO));
    assert(log_match(LOG_FATAL, LOG_WARNING));
    assert(log_match(LOG_FATAL, LOG_ERROR));
    assert(log_match(LOG_FATAL, LOG_FATAL));
}
test_log_match();


