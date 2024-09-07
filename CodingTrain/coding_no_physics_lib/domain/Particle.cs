using System;
using System.Numerics;
using Raylib_cs;
using static Raylib_cs.Raylib;
using static Raylib_cs.Raymath;

namespace Raylib;

class Particle
{
    Vector2 position;
    Vector2 velocity;
    Vector2 acceleration;
    int mass;
    double r;
    public Particle(int x, int y)
    {
        this.position = new Vector2(x, y);
        this.velocity = new Vector2(GetRandomValue(1, 2), GetRandomValue(1, 2));
        this.velocity *= GetRandomValue(1, 4);
        this.acceleration = new Vector2(0, 0);
        this.mass = GetRandomValue(1, 6);
        this.r = Math.Sqrt(this.mass) * 20;
    }

    internal void update()
    {
        this.velocity += this.acceleration;
        this.position += this.velocity;
        this.acceleration *= 0;
    }

    internal void edges()
    {
        if (this.position.X > GetScreenWidth() - this.r)
        {
            this.position.X = (float)(GetScreenWidth() - this.r);
            this.velocity.X *= -1;
        }
        else if (this.position.X < this.r)
        {
            this.position.X = (float)this.r;
            this.velocity.X *= -1;
        }

        if (this.position.Y > GetScreenHeight() - this.r)
        {
            this.position.Y = (float)(GetScreenHeight() - this.r);
            this.velocity.Y *= -1;
        }
        else if (this.position.Y < this.r)
        {
            this.position.Y = (float)this.r;
            this.velocity.Y *= -1;
        }
    }

    private void applyForce(Vector2 force)
    {
        force /= this.mass;
        this.acceleration += force;
    }

    internal void show()
    {
        DrawCircleV(this.position, (float)this.r, Color.Gray);
    }

    internal void collide(Particle other)
    {
        float distance = Vector2Distance(this.position, other.position);
        if (distance < this.r + other.r)
        {
            int mSum = this.mass + other.mass;
            Vector2 impact = other.position - this.position;
            Vector2 vDiff = other.velocity - this.velocity;

            float numA = 2 * other.mass * Vector2DotProduct(vDiff, impact);
            float denA = mSum * distance * distance;

            Vector2 deltaV = impact;

            deltaV *= numA / denA;

            this.velocity += deltaV;
        }
    }

}