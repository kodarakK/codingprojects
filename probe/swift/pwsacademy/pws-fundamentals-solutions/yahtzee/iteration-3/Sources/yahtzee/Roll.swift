/// A roll of the five dice.
struct Roll {

    /// The current values of the dice.
    ///
    /// This array is sorted for convenience.
    private(set) var dice: [Int]

    /// The number of remaining rerolls.
    ///
    /// A player has two rerolls to try to improve their roll.
    private(set) var remainingRerolls: Int

    /// Whether this roll gives the player a joker.
    ///
    /// If a player rolls a Yahtzee and the Yahtzee field is used,
    /// that player receives a joker which they can assign to any field.
    ///
    /// A `Roll` cannot determine if it's a joker on its own.
    /// It's up to you to set this property, based on the `ScoreCard.givesJoker(_:)` method.
    ///
    /// Once you set `isJoker` to `true`, the roll is over and the player loses their remaining rerolls.
    var isJoker: Bool {
        didSet {
            if isJoker {
                remainingRerolls = 0
            }
        }
    }

    /// The sum total of the dice.
    var total: Int {
        dice.reduce(0, +)
    }

    /// Initializes a roll and rolls the dice.
    init() {
        dice = []
        for _ in 1...5 {
            dice.append(Int.random(in: 1...6))
        }
        dice.sort()
        remainingRerolls = 2
        isJoker = false
    }

    /// Performs a reroll, reserving the given dice and rerolling the rest.
    mutating func reroll(reserving reservedDice: [Int]) {
        if remainingRerolls == 0 {
            return
        }
        remainingRerolls -= 1
        
        var newDice: [Int] = []
        for die in reservedDice {
            // For every die to reserve, verify the player did indeed roll this die.
            if let index = dice.firstIndex(of: die) {
                // Then remove it from the original roll so it can't be reserved twice.
                dice.remove(at: index)
                newDice.append(die)
            }
            // Alternatively, you could just initialize newDice using reservedDice.
            // These checks provide additional protection but aren't required.
        }
        while newDice.count < 5 {
            newDice.append(Int.random(in: 1...6))
        }
        dice = newDice.sorted()
    }
}

extension Roll: CustomStringConvertible {

    /// A space-separated sorted list of the dice in this roll.
    ///
    /// Example: `"1 2 2 5 6"`
    var description: String {
        dice.map(String.init).joined(separator: " ")
    }
}
