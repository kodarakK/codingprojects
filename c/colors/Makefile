
CC = gcc

SDL_PATH = C:/msys64/ucrt64

CFLAGS = -Wall -Wextra -std=c11 -I"$(SDL_PATH)/include"
LDFLAGS = -L"$(SDL_PATH)/lib" -lSDL2 -lm -mconsole

TARGET = colors.exe
SRC = colors.c

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $@ $(LDFLAGS)

run: $(TARGET)
	cp "$(SDL_PATH)/bin/SDL2.dll" .
	./$(TARGET)

clean:
	rm -f $(TARGET) SDL3.dll

.PHONY: all run clean
