
#include <Rinternals.h>

#include "waitr.h"

static const R_CallMethodDef callMethods[]  = {
  {"waitr_delay", (DL_FUNC) &waitr_delay, 1},
  {"waitr_until", (DL_FUNC) &waitr_until, 1},
  {"waitr_reset", (DL_FUNC) &waitr_reset, 0},
  {"waitr_timestamp", (DL_FUNC) &waitr_timestamp, 0},
  {NULL, NULL, 0}
};

void R_init_waitr(DllInfo *dll) {
  R_registerRoutines(dll, NULL, callMethods, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
  R_forceSymbols(dll, TRUE);

  R_RegisterCCallable("waitr_delay", "waitr_delay", (DL_FUNC) waitr_delay);
  R_RegisterCCallable("waitr_until", "waitr_until", (DL_FUNC) waitr_until);
  R_RegisterCCallable("waitr_reset", "waitr_reset", (DL_FUNC) waitr_reset);
  R_RegisterCCallable("waitr_timestamp", "waitr_timestamp", (DL_FUNC) waitr_timestamp);
}
