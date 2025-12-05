/// A player.
struct Player {

    /// The player's name, which must be unique.
    let name: String

    /// The player's score card.
    var card: ScoreCard

    /// Initializes a player with the given name and an empty score card.
    init(name: String) {
        self.name = name
        card = ScoreCard()
    }
}

// The compiler can synthesize an implementation here because all properties are Hashable.
extension Player: Hashable { }
