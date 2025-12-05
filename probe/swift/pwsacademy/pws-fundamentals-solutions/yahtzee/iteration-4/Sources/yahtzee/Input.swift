import Foundation  // Adds a trimmingCharacters(in:) method to String.

enum Input {

    /// Asks the players how many they are.
    static func askNumberOfPlayers() -> Int {
        var numberOfPlayers: Int!
        repeat {
            print("How many players? ", terminator: "")
            numberOfPlayers = Int(readLine()!)
        } while numberOfPlayers == nil || numberOfPlayers < 1
        return numberOfPlayers
    }

    /// Asks a player for their name.
    static func askName(forPlayerNumber number: Int) -> String {
        var name: String
        repeat {
            print("Player \(number), what's your name? ", terminator: "")
            name = readLine()!.trimmingCharacters(in: .whitespaces)
        } while name.count == 0  // Refuse empty names.
        return name
    }

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

    /// Asks a player to select a field to score from the given options.
    static func selectField(from options: [ScoreCard.Field: Int]) -> ScoreCard.Field {
        print("Which field would you like to score:")
        for (field, score) in options.sorted(by: { $0.key.rawValue < $1.key.rawValue }) {
            print("\(field.rawValue). \(field): \(score)")
        }
        var selection: Int!
        repeat {
            print("Your selection: ", terminator: "")
            selection = Int(readLine()!)
        } while selection == nil || !options.contains(where: { $0.key.rawValue == selection })
        return ScoreCard.Field(rawValue: selection)!
    }
}
