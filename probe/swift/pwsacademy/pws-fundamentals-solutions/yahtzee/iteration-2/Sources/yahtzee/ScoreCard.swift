/// A player's score card.
struct ScoreCard {

    /// The fields that have been scored, and their score.
    private var scoredFields: [Field: Int] = [:]

    /// The fields that haven't been scored yet.
    private var emptyFields: [Field] {
        Field.allCases.filter { !scoredFields.keys.contains($0) }
    }
    
    /// Whether the player can score the given roll.
    ///
    /// - Returns: `true` if the given roll has a value greater than zero for at least one empty field.
    func canScore(_ roll: Roll) -> Bool {
        emptyFields.map { $0.value(of: roll) }.contains { $0 > 0 }
    }

    /// The possible scores for this roll.
    ///
    /// - Returns: A dictionary containing the empty fields and the score the player would receive
    ///            were they to assign the given roll to that field.
    func scores(for roll: Roll) -> [Field: Int] {
        var scores: [Field: Int] = [:]
        for field in emptyFields {
            scores[field] = field.value(of: roll)
        }
        return scores
    }

    /// Assigns the given roll to the given field.
    ///
    /// This field must be empty, otherwise it will not be scored.
    mutating func assign(_ roll: Roll, to field: Field) {
        if !emptyFields.contains(field) {
            return
        }
        scoredFields[field] = field.value(of: roll)
    }
}

extension ScoreCard: CustomStringConvertible {

    /// A printable version of this score card.
    var description: String {
        var scores = ""
        for field in Field.allCases {
            if let score = scoredFields[field] {
                scores += "\(field): \(score)\n"
            } else {
                scores += "\(field): --\n"
            }
        }
        return scores
    }
}
