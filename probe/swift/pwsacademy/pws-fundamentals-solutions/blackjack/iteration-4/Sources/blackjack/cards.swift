/*
 A card is a tuple of a rank and a suit.
 Storing rank and suit separately (instead of in a single String) makes them easier to access.
 
 The type aliases for Card and Hand improve the clarity and readability of the code.
 */
typealias Card = (rank: String, suit: String)
typealias Hand = [Card]

/*
 The values for the different ranks.
 */
let values = [
    "A": 11,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
    "10": 10,
    "J": 10,
    "Q": 10,
    "K": 10
]

/*
 Calculates the value for a hand.
 
 Aces are considered soft (11) at first.
 If the hand exceeds 21, aces are made hard (1) one at a time,
 until the hand no longer exceeds 21, or all aces are hard.
 */
func value(for hand: Hand) -> (value: Int, isSoft: Bool) {
    var total = hand.reduce(0) {
        $0 + values[$1.rank]!
    }
    var numberOfSoftAces = hand.count { $0.rank == "A" }
    while total > 21 && numberOfSoftAces > 0 {
        numberOfSoftAces -= 1
        total -= 10
    }
    return (value: total, isSoft: numberOfSoftAces > 0)
}

/*
 Returns a description, such as "A♠", for a card.
 */
func description(for card: Card) -> String {
    "\(card.rank)\(card.suit)"
}

/*
 Returns a description for a hand of cards.
 This includes both the hand's value and the cards in the hand.

 Parameter allowBlackjack configures whether a hand is eligible for blackjack.
 This parameter is required for split hands, as these are never considered a blackjack.
 */
func description(for hand: Hand, allowBlackjack: Bool = true) -> String {
    let result = value(for: hand)
    let listOfCards = hand.map(description).joined(separator: ", ")
    if allowBlackjack && result.value == 21 && hand.count == 2 {
        return "blackjack: \(listOfCards)"
    }
    return "\(result.isSoft ? "soft " : "")\(result.value): \(listOfCards)"
}

/*
 Checks if a hand can be split.

 A hand can be split if it consists of two cards with the same value.
 These cards can be of different ranks, such as 10 and Q.
 */
func isSplittable(_ hand: Hand) -> Bool {
    if hand.count != 2 {
        return false
    }
    let valueOfFirstCard = values[hand[0].rank]!
    let valueOfSecondCard = values[hand[1].rank]!
    return valueOfFirstCard == valueOfSecondCard
}
