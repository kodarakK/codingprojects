/* Exercises 7.1 to 7.4 */

import Foundation

struct Vector {
        
    var x: Double
    var y: Double
    
    var length: Double {
        sqrt(x * x + y * y)
    }
    
    mutating func add(_ other: Vector) {
        x += other.x
        y += other.y
    }
    
    func adding(_ other: Vector) -> Vector {
        Vector(x: x + other.x, y: y + other.y)
    }
    
    mutating func subtract(_ other: Vector) {
        x -= other.x
        y -= other.y
    }
    
    func subtracting(_ other: Vector) -> Vector {
        Vector(x: x - other.x, y: y - other.y)
    }
    
    func distance(to other: Vector) -> Double {
        subtracting(other).length
    }
}

let v1 = Vector(x: 2, y: 4)
let v2 = Vector(x: -1, y: -2)
let v3 = v1.adding(v2)
print(v3.length)

/* Exercises 7.5 to 7.8 */

struct Rectangle {
    
    var corner1: Vector
    var corner2: Vector
    
    init(x: Double, y: Double, width: Double, height: Double) {
        corner1 = Vector(x: x, y: y)
        corner2 = Vector(x: x + width, y: y + height)
    }
    
    init?(corner1: Vector, corner2: Vector) {
        if corner1.x == corner2.x || corner1.y == corner2.y {
            return nil
        }
        self.corner1 = corner1
        self.corner2 = corner2
    }
    
    var width: Double {
        abs(corner2.x - corner1.x)
    }
    
    var heigth: Double {
        abs(corner2.y - corner1.y)
    }
    
    var area: Double {
        width * heigth
    }
}

if let rect = Rectangle(corner1: v1, corner2: v2) {
    print("width: \(rect.width), height: \(rect.heigth), area: \(rect.area)")
} else {
    print("v1 and v2 do not form a rectangle")
}

/* Exercises 7.9 to 7.11 */

struct Circle {
    
    static var unit = Circle(center: Vector(x: 0, y: 0), radius: 1)
    
    var center: Vector
    var radius: Double
    
    var diameter: Double {
        get {
            2 * radius
        }
        set {
            radius = newValue / 2
        }
    }
    
    var circumference: Double {
        get {
            2 * .pi * radius
        }
        set {
            radius = newValue / (2 * .pi)
        }
    }
    
    var area: Double {
        get {
            radius * radius * .pi
        }
        set {
            radius = sqrt(newValue / .pi)
        }
    }
}

let r = v1.distance(to: v2) / 2
let c1 = Circle(center: v1, radius: r)
let c2 = Circle(center: v2, radius: r)
