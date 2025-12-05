/*
 The player's hand.
 */
var playerHand: Hand = []

/*
 The dealer's hand.
 */
var dealerHand: Hand = []

// Deal the initial hands.
playerHand.append(draw())
playerHand.append(draw())
print("You have \(description(for: playerHand)).")

dealerHand.append(draw())
dealerHand.append(draw())
print("Dealer has \(description(for: dealerHand[0])).")

// Check for blackjack.
if value(for: dealerHand).value == 21 {
    print("Dealer has \(description(for: dealerHand)).")
    if value(for: playerHand).value == 21 {
        print("It's a tie.")
    } else {
        print("You lose.")
    }
} else if value(for: playerHand).value == 21 {
    print("You win.")
} else {
    // Player's turn.
    while value(for: playerHand).value < 21 {
        print("Would you like to (h)it or (s)tand?")
        let answer = one(of: ["h", "s"])
        if answer == "s" {
            break
        }
        playerHand.append(draw())
        print("You have \(description(for: playerHand)).")
    }
    if value(for: playerHand).value > 21 {
        print("Busted.")
    } else {
        // Dealer's turn.
        print("Dealer reveals \(description(for: dealerHand[1])).")
        while value(for: dealerHand).value < 17 || value(for: dealerHand) == (17, true) {
            let card = draw()
            dealerHand.append(card)
            print("Dealer draws \(description(for: card)).")
        }
        print("Dealer has \(description(for: dealerHand)).")
        if value(for: dealerHand).value > 21 {
            print("Dealer busts.\nYou win.")
        } else if value(for: playerHand).value > value(for: dealerHand).value {
            print("You win.")
        } else if value(for: playerHand).value < value(for: dealerHand).value {
            print("You lose.")
        } else {
            print("It's a tie.")
        }
    }
}
