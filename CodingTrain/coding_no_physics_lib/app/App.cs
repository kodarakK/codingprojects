using System;
using System.Numerics;
using Raylib_cs;
using static Raylib_cs.Raylib;

namespace Raylib;
class App
{
    Particle particleA;
    Particle particleB;
    public App()
    {
        particleA = new Particle(320, 60);
        particleB = new Particle(320, 300);
    }

    internal void draw()
    {
        ClearBackground(Color.White);

        particleA.collide(particleB);
        particleB.collide(particleA);

        particleA.update();
        particleB.update();

        particleA.edges();
        particleB.edges();

        particleA.show();
        particleB.show();
    }
}