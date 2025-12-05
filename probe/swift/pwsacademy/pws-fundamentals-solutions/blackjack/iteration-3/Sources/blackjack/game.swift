/*
 The player starts the game with 500 credits.
 */
let initialCredits = 500
var credits = initialCredits

/*
 A bet is fixed at 50 credits.
 */
let bet = 50

/*
 The player's hand.
 */
var playerHand: Hand = []

/*
 The dealer's hand.
 */
var dealerHand: Hand = []

/*
 Plays a single hand.
 */
func play() {
    initializeHand()
    if dealerHasBlackjack() {
        return
    }
    if playerHasBlackjack() {
        return
    }
    doPlayerTurn()
    if value(for: playerHand).value > 21 {
        print("Busted.")
        return
    }
    doDealerTurn()
    payOut()
}

/*
 Initializes a new hand and deals the first cards.
 */
func initializeHand() {
    playerHand = [draw(), draw()]
    print("You have \(description(for: playerHand)).")
    
    dealerHand = [draw(), draw()]
    print("Dealer has \(description(for: dealerHand[0])).")
}

/*
 Checks for and handles a dealer blackjack.
 If this function returns true, the hand is over.
 */
func dealerHasBlackjack() -> Bool {
    if value(for: dealerHand).value != 21 {
        return false
    }
    print("Dealer has \(description(for: dealerHand)).")
    if value(for: playerHand).value == 21 {
        print("It's a tie.")
        credits += bet
    } else {
        print("You lose.")
    }
    return true
}

/*
 Checks for and handles a player blackjack.
 This function assumes the dealer did not have a blackjack.
 If this function returns true, the hand is over.
 */
func playerHasBlackjack() -> Bool {
    if value(for: playerHand).value != 21 {
        return false
    }
    print("You win.")
    credits += 5 * bet / 2  // A blackjack pays 3:2.
    return true
}

/*
 Performs the player's turn.
 */
func doPlayerTurn() {
    while value(for: playerHand).value < 21 {
        print("Would you like to (h)it or (s)tand?")
        let answer = one(of: ["h", "s"])
        if answer == "s" {
            break
        }
        playerHand.append(draw())
        print("You have \(description(for: playerHand)).")
    }
}

/*
 Performs the dealer's turn.
 */
func doDealerTurn() {
    print("Dealer reveals \(description(for: dealerHand[1])).")
    while value(for: dealerHand).value < 17 || value(for: dealerHand) == (17, true) {
        let card = draw()
        dealerHand.append(card)
        print("Dealer draws \(description(for: card)).")
    }
    print("Dealer has \(description(for: dealerHand)).")
}

/*
 Compares the player's hand with the dealer's hand and pays out the player's winnings.
 */
func payOut() {
    if value(for: dealerHand).value > 21 {
        print("Dealer busts.\nYou win.")
        credits += 2 * bet
    } else if value(for: playerHand).value > value(for: dealerHand).value {
        print("You win.")
        credits += 2 * bet
    } else if value(for: playerHand).value < value(for: dealerHand).value {
        print("You lose.")
    } else {
        print("It's a tie.")
        credits += bet
    }
}
