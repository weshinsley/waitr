#' Functions to support sleeping for a specific number of milliseconds,
#' or wait until the relative time has reached a certain deadline in
#' milliseconds. This is lower overhead than Sys.sleep, and the use of the
#' relative time allows both taking up any slack, or catching up on lost time.
#' Likely usage is for simple animation, or any code you
#' would like to run at similar speeds on different systems, by simple tim3e
#' synchronisation.
#'
#' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
#' @export

#' Sleep for a given number of milliseconds.
#' @param delay_ms Milliseconds to wait.
#' @return The time in milliseconds, relative to the last reset.
#'
#' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
#' @export
waitr_delay <- function(delay_ms) {
  .Call(C_waitr_delay, as.integer(delay_ms))
}

#' Sleep until the relative time is on, or after a specified time.
#' @param time_ms The time in milliseconds since the last reset. If that time
#' is in the future, waitr will sleep until that time.
#' @return The new time in milliseconds, relative to the last reset.
#'
#' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
#' @export
waitr_until <- function(time_ms) {
  .Call(C_waitr_until, as.integer(time_ms))
}

#' Get the current time in milliseconds, relative to the last reset.
#' @return The current relative time in milliseconds.
#' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
#' @export
waitr_timestamp <- function() {
  .Call(C_waitr_timestamp)
}

#' Reset the current time in milliseconds to zero.
#' @return The new time in milliseconds - zero.
#' @useDynLib waitr, .registration = TRUE, .fixes = "C_"
#' @export
waitr_reset <- function() {
  .Call(C_waitr_reset)
}
