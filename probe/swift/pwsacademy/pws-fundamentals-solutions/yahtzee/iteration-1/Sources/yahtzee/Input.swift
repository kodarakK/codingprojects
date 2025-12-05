import Foundation  // Adds a trimmingCharacters(in:) method to String.

enum Input {

    /// Asks a player if they want to reroll or score their roll.
    static func playerWantsToReroll() -> Bool {
        let options = ["r", "s"]
        var answer: String
        repeat {
            print("Would you like to (r)eroll or (s)core your roll? ", terminator: "")
            answer = readLine()!.lowercased().trimmingCharacters(in: .whitespaces)
        } while !options.contains(answer)
        return answer == options[0]
    }

    /// Asks a player which dice they want to reserve.
    ///
    /// The player should input a list of values on a single line, separated by spaces.
    /// Values that aren't numbers between 1 and 6 are ignored.
    static func selectDiceToReserve() -> [Int] {
        print("Which dice would you like to reserve?")
        let numbers = readLine()!.split(separator: " ").compactMap { Int($0) }
        return numbers.filter { $0 >= 1 && $0 <= 6 }
    }
}
