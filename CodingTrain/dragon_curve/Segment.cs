using System.Drawing;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Runtime.Intrinsics;
using Raylib_cs;
using static Raylib_cs.Raylib;
using static Raylib_cs.Raymath;
using System;

namespace Raylib;

public class Segment
{
    private Vector2 a;
    private Vector2 b;

    public Segment(Vector2 a, Vector2 b)
    {
        this.a = a;
        this.b = b;
    }

    public void show()
    {
        DrawLine((int)this.a.X, (int)this.a.Y, (int)this.b.X, (int)this.b.Y, Raylib_cs.Color.Black);
    }

    internal Segment rotate(Vector2 origin)
    {
        Vector2 va = this.a - origin;
        Vector2 vb = this.b - origin;

        va = Vector2Rotate(va, -(float)Math.PI / 2);
        vb = Vector2Rotate(vb, -(float)Math.PI / 2);

        Vector2 newA = origin + va;
        Vector2 newB = origin + vb;

        Segment newSegment = new Segment(newA, newB);

        return newSegment;
    }

    public Vector2 getA()
    {
        return this.a;
    }
    public Vector2 getB()
    {
        return this.b;
    }
}