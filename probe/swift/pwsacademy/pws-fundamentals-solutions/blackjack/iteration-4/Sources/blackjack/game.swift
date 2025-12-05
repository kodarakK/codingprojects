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
 The player's hands.
 
 The player can have up to four hands.
 This means splitting is allowed up to three times.
 */
var playerHands: [Hand] = [[], [], [], []]

/*
 The player's active hand.
 */
var currentHand = 0

/*
 Whether the player has purchased insurance.
 */
var playerHasInsurance = false

/*
 Whether the player has doubled down on one or more hands.
 */
var playerHasDoubledDown = [false, false, false, false]

/*
 The dealer's hand.
 */
var dealerHand: Hand = []

/*
 Plays a single hand.
 */
func play() {
    initializeHand()
    askForInsurance()
    if dealerHasBlackjack() {
        return
    }
    if playerHasBlackjack() {
        return
    }
    doPlayerTurn()
    if allHandsBusted() {
        print("You lose.")
        return
    }
    doDealerTurn()
    payOut()
}

/*
 Initializes a new hand and deals the first cards.
 */
func initializeHand() {
    playerHands = [[draw(), draw()], [], [], []]
    currentHand = 0
    playerHasInsurance = false
    playerHasDoubledDown = [false, false, false, false]
    print("You have \(description(for: playerHands[0])).")
    
    dealerHand = [draw(), draw()]
    print("Dealer has \(description(for: dealerHand[0])).")
}

/*
 Checks if the dealer's first card is an ace.
 If so, gives the player the option to buy insurance.
 An insurance bet is half a regular bet.
 */
func askForInsurance() {
    if dealerHand.first!.rank == "A" && credits >= bet / 2 {
        print("Would you like to buy insurance?")
        if playerConfirms() {
            credits -= bet / 2
            playerHasInsurance = true
        }
    }
}

/*
 Checks for and handles a dealer blackjack.
 Also handles insurance payout.
 When this function returns true, the hand is over.
 */
func dealerHasBlackjack() -> Bool {
    if value(for: dealerHand).value != 21 {
        return false
    }
    print("Dealer has \(description(for: dealerHand)).")
    if playerHasInsurance {
        credits += 3 * bet / 2  // Insurance pays 2:1.
    }
    if value(for: playerHands[0]).value == 21 {
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
 When this function returns true, the hand is over.
 */
func playerHasBlackjack() -> Bool {
    if value(for: playerHands[0]).value != 21 {
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
    repeat {  // for all hands
        if currentHand > 0 {
            print("Continuing with hand \(currentHand + 1).")
            // Add a second card as this hand is the result of a split and has only one card.
            playerHands[currentHand].append(draw())
            print("You have \(description(for: playerHands[currentHand], allowBlackjack: false)).")
            // Split aces draw only one card.
            if playerHands[currentHand][0].rank == "A" {
                currentHand += 1
                continue  // with the next hand
            }
        }
        var firstAction = true
        while value(for: playerHands[currentHand]).value < 21 {
            let answer: String
            if firstAction && credits >= bet && playerCanSplit() {
                print("Would you like to (h)it, (s)tand, s(p)lit, or (d)ouble down?")
                answer = one(of: ["h", "s", "p", "d"])
            } else if firstAction && credits >= bet {
                print("Would you like to (h)it, (s)tand, or (d)ouble down?")
                answer = one(of: ["h", "s", "d"])
            } else {
                print("Would you like to (h)it or (s)tand?")
                answer = one(of: ["h", "s"])
            }
            firstAction = false
            if answer == "s" {
                break  // no more actions for this hand
            }
            if answer == "p" {
                credits -= bet
                let nextHand = playerHands.firstIndex { $0.isEmpty }!
                playerHands[nextHand].append(playerHands[currentHand].removeLast())
                if playerHands[currentHand][0].rank == "A" {
                    print("Splitting aces. Each hand will draw only one additional card.")
                    playerHands[currentHand].append(draw())
                    print("You have \(description(for: playerHands[currentHand], allowBlackjack: false)).")
                    break  // no more actions for this hand
                } else {
                    print("Hand split. Continuing with the current hand.")
                    // Allow resplitting and doubling down after a split.
                    firstAction = true
                }
            }
            // If the player hit, doubled down, or split cards other than aces, draw an additional card.
            playerHands[currentHand].append(draw())
            print("You have \(description(for: playerHands[currentHand], allowBlackjack: false)).")
            if value(for: playerHands[currentHand]).value > 21 {
                print("Busted.")
            }
            if answer == "d" {
                credits -= bet
                playerHasDoubledDown[currentHand] = true
                break  // no more actions for this hand
            }
        }
        currentHand += 1
    } while currentHand < playerHands.count && !playerHands[currentHand].isEmpty
}

/*
 Checks if the player is allowed to split the current hand.

 This is the case when the hand is splittable (two cards of equal value),
 and the player has an empty hand remaining.
 */
func playerCanSplit() -> Bool {
    let nextHand = playerHands.first { $0.isEmpty }
    return isSplittable(playerHands[currentHand]) && nextHand != nil
}

/*
 Checks if all of the player's hands have busted.
 */
func allHandsBusted() -> Bool {
    playerHands.allSatisfy { $0.isEmpty || value(for: $0).value > 21 }
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
    if value(for: dealerHand).value > 21 {
        print("Dealer busts.")
    }
}

/*
 Compares the player's hands with the dealer's hand and pays out the player's winnings.
 */
func payOut() {
    let playerHasMultipleHands = playerHands.count { !$0.isEmpty } > 1
    for (currentHand, hand) in playerHands.enumerated() where !hand.isEmpty && value(for: hand).value <= 21 {
        if value(for: dealerHand).value > 21 || value(for: hand).value > value(for: dealerHand).value {
            print(playerHasMultipleHands ? "You win hand \(currentHand + 1)." : "You win.")
            credits += playerHasDoubledDown[currentHand] ? 4 * bet : 2 * bet
        } else if value(for: hand).value < value(for: dealerHand).value {
            print(playerHasMultipleHands ? "You lose hand \(currentHand + 1)." : "You lose.")
        } else {
            print(playerHasMultipleHands ? "Hand \(currentHand + 1) ties." : "It's a tie.")
            credits += playerHasDoubledDown[currentHand] ? 2 * bet : bet
        }
    }
}
