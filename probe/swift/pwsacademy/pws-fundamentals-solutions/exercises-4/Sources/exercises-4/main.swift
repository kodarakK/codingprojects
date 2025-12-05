import Foundation

/* Exercise 4.1 */

func dividing(_ dividend: Double, by divisor: Double) -> (quotient: Int, remainder: Double) {
    let quotient = Int(dividend / divisor)
    let remainder = dividend.truncatingRemainder(dividingBy: divisor)
    return (quotient, remainder)
}
let result = dividing(14.2, by: 7)
print(result.quotient)
print(result.remainder)

/* Exercise 4.2 */

typealias Point = (x: Double, y: Double)

func distance(from p1: Point, to p2: Point) -> Double {
    let dx = p2.x - p1.x
    let dy = p2.y - p1.y
    return sqrt(dx * dx + dy * dy)
}
print(distance(from: (1, 1), to: (3, 3)))

/* Exercise 4.3 */

func quadraticSolutionsFor(a: Double, b: Double, c: Double) -> (Double, Double)? {
    let d = b * b - 4 * a * c
    if d > 0 {
        let x1 = (-b + sqrt(d)) / (2 * a)
        let x2 = (-b - sqrt(d)) / (2 * a)
        return (x1, x2)
    } else if d == 0 {
        let x = -b / (2 * a)
        return (x, x)
    } else {
        return nil
    }
}
if let solutions = quadraticSolutionsFor(a: 1, b: -5, c: 6) {
    print("The solutions are \(solutions.0) and \(solutions.1).")
} else {
    print("This equation has no solutions.")
}

/* Exercise 4.4 */

typealias Position = (row: Int, column: Int)

func position(after start: Position) -> Position? {
    let column = (start.column + 1) % 8
    let row = start.row + (start.column + 1) / 8
    return row < 8 ? (row, column) : nil
}
if let position = position(after: (7, 7)) {
    print("The next position is (\(position.row), \(position.column)).")
} else {
    print("There is no next position.")
}

/* Exercise 4.5 */

let next = position(after: (7, 7)) ?? (0, 0)
print("The next position is (\(next.row), \(next.column)).")
