/* Exercise 3.1 */

func toFahrenheit(celsius: Double) -> Double {
    celsius * 1.8 + 32
}

print(toFahrenheit(celsius: 0))
print(toFahrenheit(celsius: 50))

func toCelsius(fahrenheit: Double) -> Double {
    (fahrenheit - 32) / 1.8
}

print(toCelsius(fahrenheit: 32))
print(toCelsius(fahrenheit: 122))

/* Exercise 3.2 */

func toRadians(degrees: Double) -> Double {
    (degrees / 180) * .pi
}

print(toRadians(degrees: 180))
print(toRadians(degrees: 360))

func toDegrees(radians: Double) -> Double {
    (radians / .pi) * 180
}

print(toDegrees(radians: .pi))
print(toDegrees(radians: 2 * .pi))

/* Exercise 3.3 */

func toBinary(_ number: Int) -> String {
    // Convert the positive number first.
    var input = abs(number)
    var output = ""
    // repeat-while is a good fit here, as we need at least one bit in the output.
    repeat {
        let bit = input % 2  // Find the last bit.
        output = String(bit) + output
        input /= 2  // Remove the last bit (integer division truncates the result).
    } while input > 0
    // Add back the sign if needed.
    if number < 0 {
        output = "-" + output
    }
    return output
}

print(toBinary(0))
print(toBinary(7))
print(toBinary(-6))

/* Exercise 3.4 */

func toHexadecimal(_ number: Int) -> String {
    var input = abs(number)
    var output = ""
    repeat {
        let digit = input % 16
        switch digit {
        case 10:
            output = "a" + output
        case 11:
            output = "b" + output
        case 12:
            output = "c" + output
        case 13:
            output = "d" + output
        case 14:
            output = "e" + output
        case 15:
            output = "f" + output
        default:
            output = String(digit) + output
        }
        input /= 16
    } while input > 0
    if number < 0 {
        output = "-" + output
    }
    return output
}

print(toHexadecimal(0))
print(toHexadecimal(4095))
print(toHexadecimal(-100))

/* Exercise 3.5 */

func fibonacci(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    var current = 1
    var previous = 0
    var done = 1
    while done < n {
        let next = current + previous
        previous = current
        current = next
        done += 1
    }
    return current
}

print(fibonacci(0))
print(fibonacci(1))
print(fibonacci(10))

/* Exercise 3.6 */

func factorial(_ n: Int) -> Int {
    if n == 0 {
        return 1
    }
    var accumulator = 1
    for number in 1...n {
        accumulator *= number
    }
    return accumulator
}

print(factorial(0))
print(factorial(1))
print(factorial(5))

/* Exercise 3.7 */

func fibonacciRecursive(_ n: Int) -> Int {
    if n <= 1 {
        n
    } else {
        fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2)
    }
}

print(fibonacciRecursive(0))
print(fibonacciRecursive(1))
print(fibonacciRecursive(10))

/* Exercise 3.8 */

func factorialRecursive(_ n: Int) -> Int {
    if n == 0 {
        1
    } else {
        n * factorialRecursive(n - 1)
    }
}

print(factorialRecursive(0))
print(factorialRecursive(1))
print(factorialRecursive(5))

/* Exercise 3.9 */

func toBinaryRecursive(_ number: Int) -> String {
    if number < 0 {
        return "-" + toBinaryRecursive(abs(number))
    }
    let bit = number % 2
    if number / 2 == 0 {
        // This was the last bit, so don't recurse.
        return String(bit)
    } else {
        return toBinaryRecursive(number / 2) + String(bit)
    }
}

print(toBinaryRecursive(0))
print(toBinaryRecursive(7))
print(toBinaryRecursive(-6))
