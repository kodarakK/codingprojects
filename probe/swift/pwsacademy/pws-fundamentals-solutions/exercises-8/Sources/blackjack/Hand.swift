/*
 A hand of cards.
 */
struct Hand {

    /*
     The cards in this hand.
     This is a read-only property.
     Use the `receive` and `split` methods to change this property.
     */
    private(set) var cards: [Card] = []

    /*
     Whether this hand is doubled down.
     */
    var isDoubledDown = false

    /*
     Whether this hand is empty.
     */
    var isEmpty: Bool {
        cards.isEmpty
    }

    /*
     This hand's value.
     Aces are considered soft (11) at first.
     If the hand exceeds 21, aces are made hard (1) one at a time,
     until the hand no longer exceeds 21, or all aces are hard.
     */
    var value: Int {
        var total = cards.reduce(0) { $0 + $1.value }
        var numberOfSoftAces = cards.count { $0.rank == .ace }
        while total > 21 && numberOfSoftAces > 0 {
            numberOfSoftAces -= 1
            total -= 10
        }
        return total
    }

    /*
     Whether this hand contains a soft ace.
     */
    var isSoft: Bool {
        var total = cards.reduce(0) { $0 + $1.value }
        var numberOfSoftAces = cards.count { $0.rank == .ace }
        while total > 21 && numberOfSoftAces > 0 {
            numberOfSoftAces -= 1
            total -= 10
        }
        return numberOfSoftAces > 0
    }

    /*
     Whether this hand can be split.
     A hand can be split if it consists of two cards with the same value.
     These cards can be of different ranks, such as 10 and Q.
     */
    var isSplittable: Bool {
        cards.count == 2 && cards[0].value == cards[1].value
    }

    /*
     Whether the first card in this hand is an ace.
     */
    var isShowingAce: Bool {
        !cards.isEmpty && cards.first!.rank == .ace
    }

    /*
     Whether this hand is a blackjack.
     */
    var isBlackjack: Bool {
        cards.count == 2 && value == 21
    }

    /*
     Whether this hand is busted.
     */
    var isBusted: Bool {
        value > 21
    }

    /*
     Adds a card to this hand.
     */
    mutating func receive(_ card: Card) {
        cards.append(card)
    }

    /*
     Removes and returns a card from this hand to split it.
     */
    mutating func split() -> Card {
        cards.removeLast()
    }

    /*
     A description for this hand.
     This includes both the hand's value and the cards in the hand.
     Parameter `allowBlackjack` configures whether a hand is eligible for blackjack.
     This parameter is required for split hands, as these are never considered a blackjack.
     */
    func description(allowBlackjack: Bool = true) -> String {
        let listOfCards = cards.map { $0.description }.joined(separator: ", ")
        if allowBlackjack && isBlackjack {
            return "blackjack: \(listOfCards)"
        }
        return "\(isSoft ? "soft " : "")\(value): \(listOfCards)"
    }
}
