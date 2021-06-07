#ifndef WAITR_H
#define WAITR_H

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>

#include "sys/time.h"
#include <stdint.h>

#ifdef _WIN32
  #include <windows.h>
#else
  #include <unistd.h>
#endif

uint64_t waitr_now_micro_();

SEXP waitr_delay(SEXP s_micros);
SEXP waitr_until(SEXP s_time);
SEXP waitr_reset();
SEXP waitr_timestamp();

#endif
