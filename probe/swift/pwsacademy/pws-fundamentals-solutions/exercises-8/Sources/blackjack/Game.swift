/*
 The game.
 */
struct Game {

    /*
     Players start the game with 500 credits.
     */
    static let initialCredits = 500

    /*
     A bet is fixed at 50 credits.
     */
    static let bet = 50

    /*
     The player.
     */
    var player: Player

    /*
     The draw deck.
     */
    private var deck: Deck

    /*
     The dealer's hand.
     */
    private var dealer: Hand

    /*
     Initializes the game.
     Call the `play` method to start a game.
     */
    init() {
        player = Player(credits: Game.initialCredits)
        deck = Deck(size: 4)
        dealer = Hand()
    }

    /*
     Plays a single game.
     */
    mutating func play() {
        initializeFirstHand()
        askForInsurance()
        if dealerHasBlackjack() {
            return
        }
        if playerHasBlackjack() {
            return
        }
        repeat {  // for all hands
            if player.currentHandIndex > 0 {
                print("Continuing with hand \(player.currentHandIndex + 1).")
                // Add a second card as this hand is the result of a split and has only one card.
                player.receive(deck.draw())
                print("You have \(player.currentHand.description(allowBlackjack: false)).")
                // Split aces draw only one card.
                if player.currentHand.isShowingAce {
                    player.currentHandIndex += 1
                    continue  // with the next hand
                }
            }
            var firstAction = true
            while player.currentHand.value < 21 {
                let action: Action
                if firstAction && player.credits >= Game.bet && player.canSplitHand {
                    print("Would you like to \(Action.hit.description), \(Action.stand.description), \(Action.split.description) or \(Action.double.description)?")
                    action = Input.one(of: [.hit, .stand, .split, .double])
                } else if firstAction && player.credits >= Game.bet {
                    print("Would you like to \(Action.hit.description), \(Action.stand.description) or \(Action.double.description)?")
                    action = Input.one(of: [.hit, .stand, .double])
                } else {
                    print("Would you like to \(Action.hit.description) or \(Action.stand.description)?")
                    action = Input.one(of: [.hit, .stand])
                }
                firstAction = false
                if action == .stand {
                    break  // no more actions for this hand
                }
                if action == .split {
                    player.credits -= Game.bet
                    player.splitHand()
                    if player.currentHand.isShowingAce {
                        print("Splitting aces. Each hand will draw only one additional card.")
                        player.receive(deck.draw())
                        print("You have \(player.currentHand.description(allowBlackjack: false)).")
                        break  // no more actions for this hand
                    } else {
                        print("Hand split. Continuing with the current hand.")
                        // Allow resplitting and doubling down after a split.
                        firstAction = true
                    }
                }
                // If the player hit, doubled down or split cards other than aces, draw an additional card.
                player.receive(deck.draw())
                print("You have \(player.currentHand.description(allowBlackjack: false)).")
                if player.currentHand.isBusted {
                    print("Busted.")
                }
                if action == .double {
                    player.credits -= Game.bet
                    player.doubleDown()
                    break  // no more actions for this hand
                }
            }
            player.currentHandIndex += 1
        } while player.currentHandIndex < player.hands.count && !player.currentHand.isEmpty

        if player.allHandsBusted {
            print("You lose.")
            // Skip the dealer's turn and payout.
            return
        }
        doDealerTurn()
        payOut()
    }

    /*
     Deals a new hand.
     */
    private mutating func initializeFirstHand() {
        dealer = Hand()
        player.resetHands()
        player.receive(deck.draw())
        player.receive(deck.draw())
        print("You have \(player.hands[0].description()).")
        dealer.receive(deck.draw())
        dealer.receive(deck.draw())
        // Only show the dealer's first card.
        print("Dealer has \(dealer.cards[0].description).")
    }

    /*
     Checks if the dealer's first card is an ace.
     If so, gives the player the option to buy insurance.
     An insurance bet is half a regular bet.
     */
    private mutating func askForInsurance() {
        if dealer.isShowingAce && player.credits >= Game.bet / 2 {
            print("Would you like to buy insurance?")
            if Input.playerConfirms() {
                player.credits -= Game.bet / 2
                player.hasInsurance = true
            }
        }
    }

    /*
     Checks for and handles a dealer blackjack.
     Also handles insurance payout.
     When this function returns `true`, the current game is over.
     */
    private mutating func dealerHasBlackjack() -> Bool {
        if !dealer.isBlackjack {
            return false
        }
        print("Dealer has \(dealer.description()).")
        if player.hasInsurance {
            player.credits += 3 * Game.bet / 2  // Insurance pays 2:1.
        }
        if player.hasBlackjack {
            print("it's a tie.")
            player.credits += Game.bet
        } else {
            print("You lose.")
        }
        return true
    }

    /*
     Checks for and handles a player blackjack.
     This function assumes the dealer did not have a blackjack.
     When this function returns `true`, the hand is over.
     */
    private mutating func playerHasBlackjack() -> Bool {
        if !player.hasBlackjack {
            return false
        }
        print("You win.")
        player.credits += 5 * Game.bet / 2  // A blackjack pays 3:2.
        return true
    }

    /*
     Performs the dealer's turn.
     The dealer will draw cards until a value of 17 or higher is reached.
     The dealer also draws on a soft 17.
     */
    private mutating func doDealerTurn() {
        print("Dealer reveals \(dealer.cards[1].description).")
        while dealer.value < 17 || dealer.value == 17 && dealer.isSoft {
            let card = deck.draw()
            dealer.receive(card)
            print("Dealer draws \(card.description).")
        }
        print("Dealer has \(dealer.description()).")
        if dealer.isBusted {
            print("Dealer busts.")
        }
    }

    /*
     Compares the player's hands with the dealer's hand and pays out the player's winnings.
     */
    private mutating func payOut() {
        for (index, hand) in player.hands.enumerated() where !hand.isEmpty && !hand.isBusted {
            if dealer.isBusted || hand.value > dealer.value {
                print(player.hasMultipleHands ? "You win hand \(index + 1)." : "You win.")
                player.credits += hand.isDoubledDown ? 4 * Game.bet : 2 * Game.bet
            } else if hand.value < dealer.value {
                print(player.hasMultipleHands ? "You lose hand \(index + 1)." : "You lose.")
            } else {
                print(player.hasMultipleHands ? "Hand \(index + 1) ties." : "it's a tie.")
                player.credits += hand.isDoubledDown ? 2 * Game.bet : Game.bet
            }
        }
    }
}
