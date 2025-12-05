/* Exercise 5.1 */

func sum(of numbers: [Double]) -> Double {
    var sum = 0.0
    for number in numbers {
        sum += number
    }
    return sum
}
print(sum(of: [5, 3, 2, 1, 4]))

/* Exercise 5.2 */

func reversed(_ numbers: [Double]) -> [Double] {
    var result: [Double] = []
    // Iterate over the original array backwards
    var index = numbers.count - 1
    while index >= 0 {
        // and build a new array as you go.
        result.append(numbers[index])
        index -= 1
    }
    return result
}
print(reversed([3, 2, 1]))

/*
 Alternatively, you could use a for loop to iterate over the array,
 then build the reversed array by inserting elements at the front:

 func reversed(_ numbers: [Double]) -> [Double] {
    var result: [Double] = []
    for number in numbers {
        result.insert(number, at: 0)
    }
    return result
 }
 print(reversed([3, 2, 1]))

 However, as you've learned, arrays perform best when you only add or remove
 elements from the back. Therefore, this solution would perform noticably worse.
 */

/* Exercise 5.3 */

func sorted(_ numbers: [Double]) -> [Double] {
    var result: [Double] = []
    for number in numbers {
        // Compare each number to the ones you've already sorted
        var index = 0
        while index < result.count {
            // and if it's smaller than an already sorted number,
            if number < result[index] {
                // insert it before that number.
                result.insert(number, at: index)
                break
            }
            index += 1
        }
        // Otherwise, it's the largest number, so append it at the end.
        if index == result.count {
            result.append(number)
        }
    }
    return result
}
print(sorted([5, 3, 2, 1, 4]))

/* Exercise 5.4 */

func isPalindrome(_ number: Int) -> Bool {
    // Store number in a variable so we can modify it.
    // We can ignore the sign.
    var number = abs(number)
    // Chop off digits from the back, one at a time, and store them in an array.
    var digits: [Int] = []
    while number > 0 {
        digits.append(number % 10)
        number /= 10
    }
    // Iterate over the array and check whether the first digit equals the last,
    // the second digit equals the second-to-last, and so on.
    // We can stop when we reach the middle of the array.
    var index = 0
    while index < digits.count / 2 {
        if digits[index] != digits[digits.count - 1 - index] {
            // If we found a mismatch, the number isn't a palindrome, so we can stop here.
            return false
        }
        index += 1
    }
    // If all pairs matched, the number is a palindrome.
    return true
}
print(isPalindrome(0))
print(isPalindrome(-5))
print(isPalindrome(151))

/* Exercise 5.5 */

func characters(in text: String) -> [Character: Int] {
    var counts: [Character: Int] = [:]
    for character in text {
        counts[character, default: 0] += 1
    }
    return counts
}
print(characters(in: "Hello, world!"))

/* Exercise 5.6 */

func areAnagrams(_ first: String, _ second: String) -> Bool {
    characters(in: first.lowercased()) == characters(in: second.lowercased())
}
print(areAnagrams("listen", "silent"))
print(areAnagrams("Debit card", "Bad credit"))

/* Exercise 5.7 */

func words(in text: String) -> [String: Int] {
    var counts: [String: Int] = [:]
    var currentWord: String? = nil
    for character in text {
        switch character {
        case " ", "\t", "\n", ",", ";", ":", ".", "?", "!":
            // Whitespace or punctuation ends the current word.
            if let currentWord {
                counts[currentWord, default: 0] += 1
            }
            currentWord = nil
        default:
            // Continue the current word or start a new one.
            if currentWord == nil {
                currentWord = String(character)
            } else {
                currentWord!.append(character)
            }
        }
    }
    // Don't forget to count the last word as there may not be whitespace or punctuation after it.
    if let currentWord {
        counts[currentWord, default: 0] += 1
    }
    return counts
}
print(words(in: "Hello you, how are you?"))

/* Exercise 5.8 */

func stats(for text: String) -> (lineCount: Int, wordCount: Int, characterCount: Int) {
    var lineCount = 1
    var wordCount = 0
    var inWord = false
    
    for character in text {
        switch character {
        case " ", "\t", "\n", ",", ";", ":", ".", "?", "!":
            // Whitespace or punctuation ends the current word.
            if inWord {
                wordCount += 1
            }
            inWord = false
            // Check for the end of a line.
            if character == "\n" {
                lineCount += 1
            }
        default:
            inWord = true
        }
    }
    // Don't forget to count the last word as there may not be whitespace or punctuation after it.
    if inWord {
        wordCount += 1
    }
    return (lineCount, wordCount, text.count)
}
print(stats(for: """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    In tristique dolor tellus, eu sollicitudin tellus porttitor at.
    Fusce gravida sed massa nec luctus. Suspendisse ac nibh sit amet ex aliquam vulputate a non augue.
    Vivamus sollicitudin sed mi quis pretium. Suspendisse aliquet porta tincidunt.
    Suspendisse sagittis massa quis neque elementum vehicula. Morbi id volutpat enim.
    In tempus lobortis quam, nec varius neque viverra vitae. Pellentesque volutpat finibus ultricies.
    In mattis congue semper. Proin tincidunt hendrerit tincidunt. Nunc eu fringilla felis, vitae faucibus diam.
    """))

/* Exercise 5.9 */

let characterMap: [Character: Character] = [
    "a": "z",
    "b": "y",
    "c": "x",
    "d": "w",
    "e": "v",
    "f": "u",
    "g": "t",
    "h": "s",
    "i": "r",
    "j": "q",
    "k": "p",
    "l": "o",
    "m": "n",
    "n": "m",
    "o": "l",
    "p": "k",
    "q": "j",
    "r": "i",
    "s": "h",
    "t": "g",
    "u": "f",
    "v": "e",
    "w": "d",
    "x": "c",
    "y": "b",
    "z": "a"
]

func encrypt(_ message: String) -> String {
    var output = ""
    for character in message {
        if let encryptedCharacter = characterMap[character] {
            output += String(encryptedCharacter)
        } else {
            // Unsupported characters aren't encrypted.
            output += String(character)
        }
    }
    return output
}
print(encrypt("my secret password"))
print(encrypt("nb hvxivg kzhhdliw"))

/* Exercise 5.10 */

typealias Date = (day: Int, month: Int, year: Int)

func isLeapYear(_ year: Int) -> Bool {
    year.isMultiple(of: 4) && !year.isMultiple(of: 100) || year.isMultiple(of: 400)
}

let daysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

func numberOfDays(from start: Date, to end: Date) -> Int {
    var totalDays = 0
    // Store end in a variable so we can use it to count down to start.
    var end = end
    while end.year > start.year || end.month > start.month {
        // Add the number of days in this month.
        totalDays += end.day
        // Go back to the previous month
        end.month -= 1
        if end.month == 0 {
            end.year -= 1
            end.month = 12
        }
        // and reset day to the last day of that month.
        end.day = end.month == 2 && isLeapYear(end.year) ? 29 : daysPerMonth[end.month - 1]
    }
    // Finally, add the remaining number of days in this month.
    totalDays += end.day - start.day
    return totalDays
}
print(numberOfDays(from: (2, 6, 2014), to: (17, 9, 2024)))

/* Exercise 5.11 */

// These arrays store the words we need, so we can easily look them up.
let upToTwenty = [
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
]
let tens = [
    // Start with two placeholders so 20 corresponds with index 2, and so on.
    "",
    "",
    "twenty",
    "thirty",
    "fourty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety",
]
let largeUnits = [
    "thousand",
    "million",
    "billion",
    "trillion",
    "quadrillion",
    "quintillion",
]

func spellOut(_ number: Int) -> String {
    // The sign will get lost if we reach zero, so store this information now.
    let isNegative = number < 0
    // Store number in a variable and ignore its sign, since we already know that.
    var number = abs(number)
    // Start with the last two digits.
    var output = switch number % 100 {
    case 0 where number != 0:
        // Never print "zero" unless the number is actually zero.
        ""
    case let n where n < 20:
        upToTwenty[n]
    case let n where n.isMultiple(of: 10):
        "\(tens[n / 10])"
    case let n:
        "\(tens[n / 10]) \(upToTwenty[n % 10])"
    }
    // Remove the last two digits, then check the hundreds.
    number /= 100
    if number % 10 != 0 {
        output = "\(upToTwenty[number % 10]) hundred \(output)"
    }
    // Remove the hundreds.
    number /= 10
    // For the thousands and up, we can process the digits in sets of three.
    var currentUnit = 0
    while number > 0 {
        if number % 1000 != 0 {
            // Use recursion to spell out this set of three
            output = "\(spellOut(number % 1000)) \(largeUnits[currentUnit]) \(output)"
        }
        // then remove them and move on to the next set of three.
        number /= 1000
        currentUnit += 1
    }
    // Finally, add back the sign if needed.
    return isNegative ? "minus \(output)" : output
}
print(spellOut(0))
print(spellOut(-5_000_014))
print(spellOut(9_223_372_036_854_775_807))
