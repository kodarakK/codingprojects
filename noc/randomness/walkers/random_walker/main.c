#include <raylib.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <unistd.h>

const int SCREEN_WIDTH = 512;
const int SCREEN_HEIGHT = 512;

typedef struct
{
  int x;
  int y;
} Walker;

Walker walkers[1] = {{256, 256}};

void draw_walkers()
{
  for (int i=0; i<sizeof(walkers); i++)
    {
      DrawPixel(walkers[i].x, walkers[i].y, WHITE);
    }
}

void update_walkers()
{
  for (int i = 0; i < sizeof(walkers); i++)
    {
      usleep(200);
      int random_number = rand() % 4;
      switch (random_number)
        {
        case 0:
          walkers[i].x++;
          break;
        case 1:
          walkers[i].x--;
          break;
        case 2:
          walkers[i].y++;
          break;
        case 3:
          walkers[i].y--;
        }
    }
}

int main() 
{
  srand(time(NULL));
  InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib try");
  SetTargetFPS(60);
  while (!WindowShouldClose())
  {
    BeginDrawing();
    /* ClearBackground(WHITE); */
    draw_walkers();
    EndDrawing();
    update_walkers();
  }
  CloseWindow();
  return 0;
}
