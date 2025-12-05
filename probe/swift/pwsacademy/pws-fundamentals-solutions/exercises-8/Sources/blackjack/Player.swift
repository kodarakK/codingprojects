/*
 The player.
 */
struct Player {

    /*
     The player's credits.
     */
    var credits: Int

    /*
     The player's hands (up to four).
     This is a read-only property.
     Use the `receive`, `doubleDown`, `splitHand` and `resetHands` methods to modify this property.
     */
    private(set) var hands: [Hand]

    /*
     The index of the active hand.
     Starts at 0.
     */
    var currentHandIndex: Int

    /*
     Whether the player has insurance.
     */
    var hasInsurance: Bool

    /*
     Initializes a player with the given amount of initial credits.
     */
    init(credits: Int) {
        self.credits = credits
        hands = [Hand(), Hand(), Hand(), Hand()]
        currentHandIndex = 0
        hasInsurance = false
    }

    /*
     The current hand, as determined by `currentHandIndex`.
     The setter is private; other types should use methods to modify this property.
     */
    private(set) var currentHand: Hand {
        get {
            hands[currentHandIndex]
        }
        set {
            hands[currentHandIndex] = newValue
        }
    }

    /*
     Whether the player has multiple (non-empty) hands.
     */
    var hasMultipleHands: Bool {
        hands.count { !$0.isEmpty } > 1
    }

    /*
     Whether the player has a blackjack.
     A split hand isn't eligible for blackjack.
     */
    var hasBlackjack: Bool {
        hands[0].isBlackjack && !hasMultipleHands
    }

    /*
     Whether the player can split the current hand.
     This is the case when the hand is splittable (two cards of equal value),
     and the player has less than four hands.
     */
    var canSplitHand: Bool {
        let nextHand = hands.first { $0.isEmpty }
        return currentHand.isSplittable && nextHand != nil
    }

    /*
     Whether all of the player's hands have busted.
     */
    var allHandsBusted: Bool {
        hands.allSatisfy { $0.isEmpty || $0.isBusted }
    }

    /*
     Resets the player's hands to start a new game.
     */
    mutating func resetHands() {
        hands = [Hand(), Hand(), Hand(), Hand()]
        currentHandIndex = 0
        hasInsurance = false
    }

    /*
     Adds a card to the current hand.
     */
    mutating func receive(_ card: Card) {
        currentHand.receive(card)
    }

    /*
     Doubles down the current hand.
     */
    mutating func doubleDown() {
        currentHand.isDoubledDown = true
    }

    /*
     Splits the current hand (if possible).
     */
    mutating func splitHand() {
        if !canSplitHand {
            return
        }
        let nextHand = hands.firstIndex { $0.isEmpty }!
        hands[nextHand].receive(currentHand.split())
    }
}
