/*
 A deck of cards.
 Can contain multiple 52-card decks.
 */
struct Deck {

    /*
     The cards in this deck.
     This is a private property.
     Use the `draw` method to draw a card.
     */
    private var cards: [Card]

    /*
     The number of 52-card decks to shuffle.
     */
    private let size: Int

    /*
     Initializes this deck with `size` number of 52-card decks.
     */
    init(size: Int) {
        self.size = size
        cards = []
        // Initializers cannot call methods before all properties have been initialized.
        // That's why you have to assign a value to `cards` before you can call `initialize`.
        initialize()
    }

    /*
     Initializes the deck by shuffling `size` number of 52-card decks.
     */
    private mutating func initialize() {
        cards = []
        for suit in [Suit.hearts, .diamonds, .spades, .clubs] {
            for rank in [Rank.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king] {
                for _ in 1...size {
                    cards.append(Card(rank, suit))
                }
            }
        }
        cards.shuffle()
    }

    /*
     Draws a card from the deck.
     If the deck is empty, it will be reinitialized.
     */
    mutating func draw() -> Card {
        if cards.isEmpty {
            initialize()
        }
        return cards.removeLast()
    }
}
