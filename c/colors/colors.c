#include <stdio.h>
#include <SDL2/SDL.h>
#include <math.h>

#define WIDTH 1200
#define HEIGHT 900

int counter = 0;

void animate(SDL_Window *pwindow, SDL_Surface *psurface) {
  SDL_FillRect(psurface, NULL, 0x0);
  /* Uint32 color = 0x0; */
  int r = 0, g = 0, b = 0;
  SDL_PixelFormat *pformat = psurface->format;
  for ( int x = 0; x < WIDTH; x++) {
    for ( int y = 0; y < HEIGHT; y++) {
      SDL_Rect rect = (SDL_Rect) {x, y, 1, 1};
      /* Uint32 color = SDL_MapRGB(pformat, r++, g++, b++); */
      /* SDL_FillRect(psurface, &rect, color); */
      /* verdergaan:  */
      /* https://youtu.be/GhDX2t_tQtc?si=eK52KeDjZSgXj69g&t=2141 */
    }
  }
}

int main()
{
  SDL_Init(SDL_INIT_VIDEO);
  SDL_Window *pwindow = SDL_CreateWindow("COLORS", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, WIDTH, HEIGHT, 0);
  SDL_Surface *psurface = SDL_GetWindowSurface(pwindow);
 
  int game_is_still_running = 1;
  
  while (game_is_still_running) {
    SDL_Event event;
    while (SDL_PollEvent(&event)) {
      if (event.type == SDL_QUIT) {
	game_is_still_running = 0;
      }
      animate(pwindow, psurface);
      SDL_UpdateWindowSurface(pwindow);
    }
    SDL_Delay(50);
  } 
}
