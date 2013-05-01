#include "dpiheader.h"

#include "HsFFI.h"

#ifdef __GLASGOW_HASKELL__
#include "hsMain_stub.h"
#endif

int write_data(char data) {
  int read_data;
  v_write_data(data, &read_data);
  return read_data;
}

int c_main(void) {
  hs_init(0, 0);
  hsMain();
  hs_exit();

  return 0;
}
