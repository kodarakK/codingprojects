extension ScoreCard {

    /// A field on a score card.
    ///
    /// Fields have a fixed order, determined by their raw value.
    /// For convenience, these raw values start at 1.
    enum Field: Int, CaseIterable {
        
        case ones = 1
        case twos
        case threes
        case fours
        case fives
        case sixes
        case threeOfAKind
        case fourOfAKind
        case fullHouse
        case smallStraight
        case largeStraight
        case chance
        case yahtzee

        /// The value a roll would have, were it assigned to this field.
        func value(of roll: Roll) -> Int {
            switch self {
            case .ones, .twos, .threes, .fours, .fives, .sixes:
                let numberOfMatches = frequencies(in: roll)[rawValue]!
                return numberOfMatches * rawValue
            case .threeOfAKind:
                if frequencies(in: roll).values.contains(where: { $0 >= 3 }) {
                    return roll.total
                } else {
                    return 0
                }
            case .fourOfAKind:
                if frequencies(in: roll).values.contains(where: { $0 >= 4 }) {
                    return roll.total
                } else {
                    return 0
                }
            case .fullHouse:
                let counts = frequencies(in: roll).values
                if counts.contains(3) && counts.contains(2) {
                    return 25
                } else {
                    return 0
                }
            case .smallStraight:
                let counts = frequencies(in: roll).sorted { $0.key < $1.key }.map { $0.value }
                if counts[0...3].allSatisfy({ $0 >= 1 }) ||  // 1, 2, 3, 4
                   counts[1...4].allSatisfy({ $0 >= 1 }) ||  // 2, 3, 4, 5
                   counts[2...5].allSatisfy({ $0 >= 1 }) {   // 3, 4, 5, 6
                    return 30
                } else {
                    return 0
                }
            case .largeStraight:
                let counts = frequencies(in: roll).sorted { $0.key < $1.key }.map { $0.value }
                if counts[0...4] == [1, 1, 1, 1, 1] ||  // 1, 2, 3, 4, 5
                   counts[1...5] == [1, 1, 1, 1, 1] {   // 2, 3, 4, 5, 6
                    return 40
                } else {
                    return 0
                }
            case .chance:
                return roll.total
            case .yahtzee:
                if frequencies(in: roll).values.contains(5) {
                    return 50
                } else {
                    return 0
                }
            }
        }

        /// Returns the number of times each value was rolled.
        ///
        /// The returned dictionary is complete; it includes zeros for values that weren't rolled.
        private func frequencies(in roll: Roll) -> [Int: Int] {
            var counts = [1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0]
            for die in roll.dice {
                counts[die]! += 1
            }
            return counts
        }
    }
}

extension ScoreCard.Field: CustomStringConvertible {

    /// The name of this field.
    var description: String {
        switch self {
        case .ones: "Ones"
        case .twos: "Twos"
        case .threes: "Threes"
        case .fours: "Fours"
        case .fives: "Fives"
        case .sixes: "Sixes"
        case .threeOfAKind: "Three of a kind"
        case .fourOfAKind: "Four of a kind"
        case .fullHouse: "Full house"
        case .smallStraight: "Small straight"
        case .largeStraight: "Large straight"
        case .chance: "Chance"
        case .yahtzee: "Yahtzee"
        }
    }
}
