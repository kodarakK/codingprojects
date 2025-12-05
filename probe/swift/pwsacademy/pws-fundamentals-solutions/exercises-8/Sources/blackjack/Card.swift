/*
 A card's suit is an enumerated type.
 This type has a raw value because there is a one-to-one mapping
 between a suit and its corresponding symbol.
 */
enum Suit: String {

    case hearts = "♥"
    case diamonds = "♦"
    case spades = "♠"
    case clubs = "♣"
}

/*
 A card's rank is an enumerated type.
 This type has a raw value because there is a one-to-one mapping
 between a rank and its corresponding string value.
 */
enum Rank: String {

    case ace = "A"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"

    /*
     This rank's value.
     Aces are soft (11) by default.
     */
    var value: Int {
        switch self {
        case .ace: 11
        case .two: 2
        case .three: 3
        case .four: 4
        case .five: 5
        case .six: 6
        case .seven: 7
        case .eight: 8
        case .nine: 9
        case .ten, .jack, .queen, .king: 10
        }
    }
}

/*
 A card is a combination of a rank and a suit.
 */
struct Card {

    let rank: Rank
    let suit: Suit

    /*
     Creates a card with the given rank and suit.

     This custom initializer lets you create a card as `Card(.ace, .spades)` instead of
     `Card(rank: .ace, suit: .spades)`, which needlessly repeats type information.
     */
    init(_ rank: Rank, _ suit: Suit) {
        self.rank = rank
        self.suit = suit
    }

    /*
     This card's value.
     This is a pass-through property that returns the rank's value.
     It exists only for ease-of-use.
     */
    var value: Int {
        rank.value
    }

    /*
     A description, such as "A♠", for this card.
     */
    var description: String {
        "\(rank.rawValue)\(suit.rawValue)"
    }
}
