GCC_ARGS = -Wall -Wextra -g
CC = gcc

run: build
	./qr

build:
	$(CC) $(GCC_ARGS) -o qr qr.c qrcodegen.c TinyPngOut.c

to_png: build
	./qr

clean:
	rm out.png
	rm qr

