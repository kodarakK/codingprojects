#include <raylib.h>
#include <stdio.h>

int main()
{
  const int screen_width = 512;
  const int screen_height = 512;

  InitWindow(screen_width, screen_height, "hellorld");
  while (!WindowShouldClose())
    {
      BeginDrawing();
      ClearBackground(RAYWHITE);
      EndDrawing();
    }
  CloseWindow();
  return 0;
}
