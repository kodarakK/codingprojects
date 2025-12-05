/*
 The deck of cards to draw from.
 */
var deck: [Card] = []

/*
 Initializes the deck by shuffling four 52-card decks.
 */
func initializeDeck() {
    deck = []
    for suit in ["♥", "♦", "♠", "♣"] {
        for rank in values.keys {
            for _ in 1...4 {
                // Add each card four times.
                // This is more efficient than repeating the outer loops four times.
                deck.append((rank: rank, suit: suit))
            }
        }
    }
    deck.shuffle()
}

/*
 Draws a card from the deck.
 If the deck is empty, it will be reinitialized.
 */
func draw() -> Card {
    if deck.isEmpty {
        initializeDeck()
    }
    return deck.removeLast()
}
