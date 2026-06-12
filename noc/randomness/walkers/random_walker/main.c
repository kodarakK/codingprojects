#include "raylib.h"
#include <stdio.h>

int main() 
{
  const int SCREEN_WIDTH = 512;
  const int SCREEN_HEIGHT = 512;
  InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib try");
  SetTargetFPS(60);

  while (!WindowShouldClose())
  {
    BeginDrawing();
    ClearBackground(WHITE);
    DrawText("It works!", 20, 20, 20, BLACK);
    EndDrawing();
  }
  CloseWindow();
  return 0;
}
