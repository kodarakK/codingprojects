/// A player's score card.
struct ScoreCard {

    /// The fields that have been scored, and their score.
    private var scoredFields: [Field: Int] = [:]

    /// The number of bonus Yahtzees the player has rolled.
    /// Each one is worth 100 points.
    ///
    /// A Yahtzee roll only results in a bonus Yahtzee if the player already has a Yahtzee on their card.
    private var bonusYahtzees = 0

    /// The fields that haven't been scored yet.
    private var emptyFields: [Field] {
        Field.allCases.filter { !scoredFields.keys.contains($0) }
    }

    /// The upper section ("three of each") bonus, worth 35 points, which is awarded
    /// if the sum total of the fields `.ones` through `.sixes` is at least 63.
    private var threeOfEachBonus: Int {
        let sum = [Field.ones, .twos, .threes, .fours, .fives, .sixes]
            .map { scoredFields[$0, default: 0] }
            .reduce(0, +)
        return sum >= 63 ? 35 : 0
    }

    /// The total score, including bonuses.
    var total: Int {
        scoredFields.values.reduce(0, +) + threeOfEachBonus + bonusYahtzees * 100
    }

    /// Whether the given roll gives the player a joker.
    ///
    /// - Returns: `true` if the roll is a Yahtzee and the Yahtzee field has been scored
    ///            (this score can be a zero).
    func givesJoker(_ roll: Roll) -> Bool {
        Field.yahtzee.value(of: roll) != 0 && scoredFields[.yahtzee] != nil
    }

    /// Whether the player can score the given roll.
    ///
    /// - Returns: `true` if the given roll has a value greater than zero for at least one empty field,
    ///             or if the roll is a joker.
    func canScore(_ roll: Roll) -> Bool {
        roll.isJoker || emptyFields.map { $0.value(of: roll) }.contains { $0 > 0 }
    }

    /// The possible scores for this roll.
    ///
    /// - Returns: A dictionary containing the empty fields and the score the player would receive
    ///            were they to assign the given roll to that field.
    func scores(for roll: Roll) -> [Field: Int] {
        if roll.isJoker {
            let numberField = Field(rawValue: roll.dice[0])!
            // If the corresponding number field is empty, the player must choose that field.
            if scoredFields[numberField] == nil {
                return [numberField: roll.total]
            }
        }
        var scores: [Field: Int] = [:]
        for field in emptyFields {
            scores[field] = field.value(of: roll)
        }
        return scores
    }

    /// Assigns the given roll to the given field.
    ///
    /// This field must be empty, otherwise it will not be scored.
    /// If the roll is a bonus Yahtzee, it will be counted as well.
    mutating func assign(_ roll: Roll, to field: Field) {
        if !emptyFields.contains(field) {
            return
        }
        scoredFields[field] = field.value(of: roll)
        if roll.isJoker && scoredFields[.yahtzee] == 50 {
            bonusYahtzees += 1
        }
    }
}

extension ScoreCard: CustomStringConvertible {

    /// A printable version of this score card. Includes bonuses and a total.
    var description: String {
        var scores = ""
        for field in Field.allCases {
            if let score = scoredFields[field] {
                scores += "\(field): \(score)\n"
            } else {
                scores += "\(field): --\n"
            }
            if field == .sixes {
                scores += "Bonus (>= 63): \(threeOfEachBonus)\n"
            }
        }
        if bonusYahtzees > 0 {
            scores += "Bonus Yathzees (\(bonusYahtzees)): \(bonusYahtzees * 100)\n"
        }
        scores += "Total: \(total)\n"
        return scores
    }
}
