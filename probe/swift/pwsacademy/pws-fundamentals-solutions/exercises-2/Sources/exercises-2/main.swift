import Foundation

/* Exercise 2.1 */

let row = 7
let column = 7

var nextRow = row
var nextColumn = column + 1
if nextColumn > 7 {
    nextColumn = 0
    nextRow += 1
}
if nextRow > 7 {
    nextRow = 0
}

print("The position after (\(row), \(column)) is (\(nextRow), \(nextColumn)).")

/* Exercise 2.2 */

let a = 1.0
let b = -5.0
let c = 6.0

let d = b * b - 4 * a * c
if d > 0 {
    let x1 = (-b + sqrt(d)) / (2 * a)
    let x2 = (-b - sqrt(d)) / (2 * a)
    print("The solutions are \(x1) and \(x2).")
} else if d == 0 {
    let x = -b / (2 * a)
    print("Both solutions are \(x).")
} else {
    print("This equation has no solutions.")
}

/* Exercise 2.3 */

let b1 = true, b2 = false, b3 = true

print(b1 && b2 || b1 && !b2 && b3)
print((b1 && b2) || ((b1 && (!b2)) && b3))

/* Exercise 2.4 */

let month = "july"
let year = 2024

let isLeapYear = year.isMultiple(of: 4) && !year.isMultiple(of: 100) || year.isMultiple(of: 400)
if month == "january" || month == "march" || month == "may" || month == "july" || month == "august" || month == "october" || month == "december" {
    print("This month has 31 days.")
} else if month == "april" || month == "june" || month == "september" || month == "november" {
    print("This month has 30 days.")
} else if month == "february" && isLeapYear {
    print("This month has 29 days.")
} else if month == "february" {
    print("This month has 28 days.")
} else {
    print("This is not a valid month.")
}

/* Exercise 2.5 */

let number = 1024.0

// To determine if this number is a power of 2, we can repeatedly divide it by 2,
// and see if we end up with 1:

var dividend = number
while dividend.remainder(dividingBy: 2) == 0 {
    dividend /= 2
}
if dividend == 1 {
    print("\(number) is a power of 2.")
} else {
    print("\(number) is not a power of 2.")
}

// Alternatively, we can check if the base 2 logarithm of the number is an integer:

let log = log2(number)
if log.remainder(dividingBy: 1) == 0 {
    print("\(number) is a power of 2.")
} else {
    print("\(number) is not a power of 2.")
}

/* Exercise 2.6 */

var exponent = 0
var power = 1
while exponent <= 10 {
    print("\(exponent)\t\(power)")
    exponent += 1
    power *= 2
}

/* Exercise 2.7 */

var n = 10

if n <= 1 {
    // The zeroth number is 0 and the first number is 1.
    print("Fibonacci number \(n) is \(n).")
} else {
    var current = 1
    var previous = 0
    var done = 1
    while done < n {
        let next = current + previous
        previous = current
        current = next
        done += 1
    }
    print("Fibonacci number \(n) is \(current).")
}

/* Exercise 2.8 */

n = 5

var accumulator = 1
var done = 1
while done < n {
    done += 1
    accumulator *= done
}

print("\(n)! is \(accumulator).")

/* Exercise 2.9 */

let targetPips = 7

var combinationsFound = 0
var pipsOnFirstDie = 1
while pipsOnFirstDie <= 6 {
    var pipsOnSecondDie = 1
    while pipsOnSecondDie <= 6 {
        if pipsOnFirstDie + pipsOnSecondDie == targetPips {
            combinationsFound += 1
        }
        pipsOnSecondDie += 1
    }
    pipsOnFirstDie += 1
}
let percentage = Int(Double(combinationsFound) / 36 * 100)

print("The odds of rolling a \(targetPips) are \(combinationsFound) in 36 or \(percentage)%.")
