##' @description This package provides an internal clock measured in milliseconds since
##' the last reset, with functions to get the current timestamp, reset it to
##' zero, sleep for a number of milliseconds, or sleep until the relative time
##' is beyond a certain number of milliseconds. All functions return the relative
##' time in millseconds at the end of the function call.
##'
##' This aim is to provide a lower overhead alternative to Sys.sleep, for
##' the purpose of simple animation at a reasonably consistent frame-rate,
##' regardless of platform and system.
##'
##' @title Sleep for, or until a given time
##' @rdname waitr
##' @param delay_ms Milliseconds to wait.
##' @return The time in milliseconds, relative to the last reset.
##' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
##' @export
waitr_delay <- function(delay_ms) {
  .Call(C_waitr_delay, as.integer(delay_ms))
}

##' @title Sleep until the relative time is beyond a specified time
##' @param time_ms Clock time to wait for, in milliseconds.
##' @rdname waitr
##' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
##' @export
waitr_until <- function(time_ms) {
  .Call(C_waitr_until, as.integer(time_ms))
}

##' @title Get current time in milliseconds, relative to the last reset
##' @rdname waitr
##' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
##' @export
waitr_timestamp <- function() {
  .Call(C_waitr_timestamp)
}

##' @title Reset the current time to zero
##' @rdname waitr
##' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
##' @export
waitr_reset <- function() {
  .Call(C_waitr_reset)
}
