import Foundation

/* Exercise 1.1 */

let exercises = 11
var exercisesSolved = 0
exercisesSolved += 1

/* Exercise 1.2 */

print(5 * 3 - 4 / 2 * 2)
print((5 * 3) - ((4 / 2) * 2))
exercisesSolved += 1

/* Exercise 1.3 */

var a = 7.0
var b = 5.0

let temporary = a
a = b
b = temporary
print(a)
print(b)
exercisesSolved += 1

/* Exercise 1.4 */

let average = (a + b) / 2
exercisesSolved += 1

/*
 Q: Why is it important that a and b are of type Double?
 A: If a and b were of type Int, the result would be truncated to an Int as well.
 */
 
/* Exercise 1.5 */

let fahrenheit = 121.0
let celsius = (fahrenheit - 32) / 1.8
exercisesSolved += 1

/* Exercise 1.6 */

var row = 3
var column = 4
var position = row * 8 + column

position = 54
row = position / 8  // Integer division truncates the result.
column = position % 8
exercisesSolved += 1

/* Exercise 1.7 */

let dividend = 9.4
let divisor = 3.1
let quotient = Int(dividend / divisor)
let remainder = dividend - divisor * Double(quotient)
exercisesSolved += 1

/* Exercise 1.8 */

let degrees = 360.0
let radians = (degrees / 180) * .pi
exercisesSolved += 1

/* Exercise 1.9 */

let x1 = 1.0
let y1 = 1.0
let x2 = 4.0
let y2 = 5.0
let dx = x2 - x1
let dy = y2 - y1
let distance = sqrt(dx * dx + dy * dy)
exercisesSolved += 1

/* Exercise 1.10 */

var savings = 1000.0
let interestRate = 0.03
let years = 10.0

savings *= pow(1 + interestRate, years)
exercisesSolved += 1

/* Exercise 1.11 */

exercisesSolved += 1
let percentage = Double(exercisesSolved) / Double(exercises)
print(Int(percentage * 100))
