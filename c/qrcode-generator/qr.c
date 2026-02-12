#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include "qrcodegen.h"
#include "TinyPngOut.h"

int main() 
{

  /* via text */
  uint8_t qr[qrcodegen_BUFFER_LEN_MAX];
  uint8_t tempBuffer[qrcodegen_BUFFER_LEN_MAX];
  bool ok = qrcodegen_encodeText("Hellorld",
				 tempBuffer, qr, qrcodegen_Ecc_MEDIUM,
				 qrcodegen_VERSION_MIN, qrcodegen_VERSION_MAX,
				 qrcodegen_Mask_AUTO, true);
  if (!ok)
    return 1;


  FILE* fd = fopen("out.png", "w");
  if (fd == NULL) {
    printf("couldnt open output file\n");
    return -1;
  }
    
  
  int size = qrcodegen_getSize(qr);

  struct TinyPngOut writer;
  

  enum TinyPngOut_Status init_status = TinyPngOut_init(&writer, size, size, fd);
	
    if (init_status != TINYPNGOUT_OK) {
      printf("couldnt init writer: %d\n", init_status);
      return -1;    
    }


  uint8_t rgb_black[] = {0, 0, 0};
  uint8_t rgb_white[] = {255, 255, 255};
  
  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      for (int i = 0; i < 8; i++){
	bool color = qrcodegen_getModule(qr, x, y);
	TinyPngOut_write(&writer, color ? rgb_white : rgb_black, 1);      	
      }
    }
  }

  fclose(fd);
  return 0;
}
