#include "waitr.h"

uint64_t t0_micro = 0;
int t0_micro_unset = 1;

/***********************************************/
// Wait for a specified number of milliseconds //
/***********************************************/

int waitr_delay_(int millis) {

  if (t0_micro_unset == 1) {
    waitr_reset();
  }

  if (millis > 0) {
    #ifdef _WIN32
      Sleep(millis);
    #else
      usleep(millis * 1000);
    #endif
  }
  return (int) ((waitr_now_micro_() - t0_micro) / 1000);
}

/***************************************************************/
// Wait until the relative clock matches deadline milliseconds //
/***************************************************************/

int waitr_until_(int deadline_millis) {

  if (t0_micro_unset == 1) {
    waitr_reset();
  }

  int now_millis = ((waitr_now_micro_() - t0_micro) / 1000);
  waitr_delay_(deadline_millis - now_millis);
  return (int) ((waitr_now_micro_() - t0_micro) / 1000);
}

/*********************************************/
// Get current absolute time in microseconds //
/*********************************************/

uint64_t waitr_now_micro_() {
  struct timeval tv;
  gettimeofday(&tv,NULL);
  return (uint64_t) ((1000000 * tv.tv_sec) + tv.tv_usec);
}

/************************/
/*       Wrappers       */
/************************/

SEXP waitr_delay(SEXP delay_millis) {
  return ScalarInteger(waitr_delay_(INTEGER(delay_millis)[0]));
}

SEXP waitr_until(SEXP time_millis) {
  return ScalarInteger(waitr_until_(INTEGER(time_millis)[0]));
}

SEXP waitr_reset() {
  t0_micro = waitr_now_micro_();
  t0_micro_unset = 0;
  return waitr_timestamp();
}

SEXP waitr_timestamp() {
  return ScalarInteger((int) ((waitr_now_micro_() - t0_micro) / 1000));
}