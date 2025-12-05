# Analysis for Blackjack

This is an analysis document for Challenge 2: “Blackjack”. It describes the requirements and scenarios for the solution project. Your analysis may be different, depending on the rules you chose to implement, but it should contain approximately the same information.

This analysis follows the iterations suggested in the challenge. Each requirement and scenario mentions the iteration it belongs to.

## Requirements

The main requirement for this challenge is to implement the game of Blackjack according to the rules in this document. Other requirements are listed below these rules.

### Rules

Blackjack is a card game in which the player draws cards to achieve a higher total than the dealer, without exceeding 21.

#### Cards (iteration 1)

The draw deck consists of four regular 52-card decks shuffled together. The values of these cards are as follows:

- Number cards are worth their face value: 2 through 10.
- Jacks, queens, and kings are worth 10.
- Aces are worth either 11 (a **soft** ace), or 1 (a **hard** ace). 

Aces are soft and automatically become hard in a hand that exceeds 21. For example, a hand containing an ace and a five is worth 16 (the ace is soft), whereas a hand containing an ace, a five, and a six is worth 12 (the ace is hard). A hand containing two aces and a five is worth 17 (one ace is soft).

#### Initial hands (iteration 1)

At the start of the game, both the player and the dealer receive an initial hand of two cards. The player’s cards are dealt face up but only one of the dealer’s cards is dealt face up. This gives the player some — but not all — information about the dealer’s hand.

#### Blackjack (iteration 1)

An initial hand that consists of an ace and a card with a value of ten is called a **blackjack**. This is the best hand in the game; it beats hands that also total 21 but have more than two cards.

If either the player or the dealer has a blackjack, they immediately win the game. If they both have a blackjack, the game ends in a tie (**push**).

#### Hit, stand, and bust (iteration 1)

If neither the player nor the dealer has a blackjack, the player can draw additional cards to increase their hand. The player can continue drawing cards (**hit**) until they either accept their hand (**stand**) or their hand exceeds 21, in which case they lose the game (**bust**).

#### Dealer’s turn (iteration 2)

If the player finishes their turn without busting, the dealer also takes a turn. The dealer’s actions are predetermined: the dealer must hit until they have a hand of 17 or higher, at which point they must stand. The dealer also hits on a soft 17.

If the dealer busts, the player wins. Otherwise, the highest hand wins. If both hands have the same value, the game ends in a tie.

#### Betting (iteration 3)

Blackjack is a gambling game. Players start the game with 500 credits and bet 50 credits on every hand they play. If the player wins a hand, they recover their bet and win an additional 50 credits. If they lose a hand, they lose their bet. If the hand ends in a tie, the player recovers their bet. 

The player gets an additional 25 credits for winning with a blackjack. This means a blackjack pays 3:2 whereas a regular hand pays 1:1.

#### Doubling down (iteration 4)

After the initial deal, the player may **double down** as their first action. The player then increases their bet to 100 and draws one additional card, after which they must stand.

A doubled down hand pays 1:1 but with double the risk and reward.

#### Splitting (iteration 4)

If the player’s initial two cards have the same value, the player may **split** their hand as their first action. The dealer then separates the cards, creating two hands, and the player places an additional bet to pay for the second hand.

Split hands are independent. Upon starting a split hand, the player is dealt a second card to create a new initial hand. The player must then finish this hand before moving on to the next one.

The following restrictions apply to split hands:

- A split hand is never considered a blackjack and pays 1:1.
- Split aces each receive one more card, after which the player must stand.
- The player cannot have more than four hands. This means the player can split an already split hand as long as this doesn’t result in a fifth hand.

Other than this, a split hand plays and pays like a regular hand. The player may also double down a split hand.

#### Insurance (iteration 4)

If the dealer’s visible card is an ace, the player may purchase **insurance** against a blackjack from the dealer.

Insurance is a side bet of 25 credits that pays 2:1. If the player purchases insurance and the dealer has a blackjack, the player recovers their insurance bet and wins 50 credits. If the dealer doesn’t have a blackjack, the insurance bet is lost, and the hand continues as normal.

### User interface (iteration 1)

The game uses the terminal to interface with the player.

### Player count (iteration 1)

The game supports only a single player.

### Emojis (iteration 1)

The game displays suits using the following emojis:

- Hearts: ♥
- Diamonds: ♦
- Spades: ♠
- Clubs: ♣

## Scenarios

The following scenarios describe the interactions between the player and the game. Each scenario includes one or more examples that show the expected input and output.

### Scenario 1 (iteration 1)

This scenario describes the start of the game and the player’s turn. It excludes the dealer’s turn and supports only the actions hit and stand. It also ignores betting.

1. The game deals two cards to the player and displays them.
2. The game deals two cards to the dealer and displays the first card.
3. The game checks both hands for a blackjack. If either the player or the dealer has a blackjack, they win. If they both have a blackjack, the game ends in a tie. In both cases, the game displays an appropriate message. Otherwise, continue with the following steps.
4. The game asks the player if they want to hit or stand.
5. The player inputs their selection.
6. If the player chose to stand, their turns ends.
7. Otherwise, the game deals the player a new card and displays their new hand.
8. If the player’s hand totals 21, their turn ends.
9. If the player’s hand exceeds 21, they bust and the game displays an appropriate message.
10. Otherwise, return to Step 4.

Example 1.1, in which the player hits twice, then stands:

```
You have 13: 10♠, 3♦.
Dealer has 6♣.
Would you like to (h)it or (s)tand?
h
You have 15: 10♠, 3♦, 2♣.
Would you like to (h)it or (s)tand?
h
You have 19: 10♠, 3♦, 2♣, 4♦.
Would you like to (h)it or (s)tand?
s
```

Example 1.2, in which the player busts:

```
You have 12: 2♣, 10♣.
Dealer has J♦.
Would you like to (h)it or (s)tand?
h
You have 22: 2♣, 10♣, K♠.
Busted.
```

Example 1.3, in which the player has a blackjack:

```
You have blackjack: 10♣, A♥.
Dealer has 5♠.
You win.
```

Example 1.4, in which the dealer has a blackjack:

```
You have soft 12: A♣, A♦.
Dealer has J♦.
Dealer has blackjack: J♦, A♣.
You lose.
```

Example 1.5, in which both the player and the dealer have a blackjack:

```
You have blackjack: 10♣, A♥.
Dealer has A♦️.
Dealer has blackjack: A♦️, J♠️.
It's a tie.
```

### Scenario 2 (iteration 2)

This scenario follows the previous one and describes the dealer’s turn. It assumes that neither the player nor the dealer has a blackjack, and that the player finished their turn without busting.

1. The game displays the dealer’s second card.
2. If the dealer’s hand is less than 17 or the dealer has a soft 17, the dealer draws a new card and the game displays this card. Otherwise, skip to Step 4.
3. Repeat the previous step.
4. The game displays the dealer’s hand.
5. If the dealer’s hand exceeds 21, the dealer busts and the player wins. The game displays an appropriate message.
6. Otherwise, the game compares the dealer’s hand with the player’s hand and the highest hand wins. If both hands have the same value, the game ends in a tie. In both cases, the game displays an appropriate message.

> **Note**: The following examples include the output of the previous scenario for context.

Example 2.1, in which the dealer draws an additional card, then busts:

```
You have 18: J♦, 8♠.
Dealer has 7♣.
Would you like to (h)it or (s)tand?
s
Dealer reveals 8♠.
Dealer draws 10♥.
Dealer has 25: 7♣, 8♠, 10♥.
Dealer busts.
You win.
```

Example 2.2, in which the dealer’s hand beats the player’s hand:

```
You have 19: 10♣, 9♠.
Dealer has Q♣.
Would you like to (h)it or (s)tand?
s
Dealer reveals K♥.
Dealer has 20: Q♣, K♥.
You lose.
```

Example 2.3, which ends in a tie:

```
You have 19: 9♠, J♠.
Dealer has 9♦.
Would you like to (h)it or (s)tand?
s
Dealer reveals 10♣.
Dealer has 19: 9♦, 10♣.
It's a tie.
```

### Scenario 3 (iteration 3)

This scenario builds on the previous two and describes a game where the player can play and bet on multiple hands.

1. The game displays a welcome message and informs the player of the bet size.
2. The player receives 500 credits to start the game with.
3. The game displays how many credits the player has, and asks them if they want to play a hand.
4. If the player confirms, they place a bet and the game starts a new hand. If the player declines, skip to Step 7.
5. Follow Scenarios 1 and 2 to play the hand. If the hand ended in a tie, the player retrieves their bet. If the player won, they retrieve their bet and win an additional bet, plus an extra half bet if they won with a blackjack.
6. If the player has enough credits to play a new hand, return to Step 3. If not, continue with Step 7.
7. The game displays how many credits the player has left, and how many they’ve won or lost.

Example 3.1, in which the player plays a single hand:

```
Welcome to Blackjack!
A bet is 50 credits.

You have 500 credits.
Would you like to play a hand?
y
You have 11: 2♦, 9♥.
Dealer has 7♥.
Would you like to (h)it or (s)tand?
h
You have 21: 2♦, 9♥, K♣.
Dealer reveals 10♠.
Dealer has 17: 7♥, 10♠.
You win.

You have 550 credits.
Would you like to play a hand?
n
You've ended the game with 550 credits.
That's 50 credits won!
```

Example 3.2, in which the player runs out of credits:

```
Welcome to Blackjack!
A bet is 50 credits.

You have 500 credits.
Would you like to play a hand?
y

(...)

You have 50 credits.
Would you like to play a hand?
y
You have 13: K♥, 3♥.
Dealer has J♣️.
Would you like to (h)it or (s)tand?
h
You have 23: K♥, 3♥, J♥.
Busted.

You've ended the game with 0 credits.
You've lost 500 credits.
```

### Scenario 4 (iteration 4)

This scenario modifies Scenario 3 to include doubling down. Replace Step 5 with the following:

1. The game deals two cards to the player and displays them.
2. The game deals two cards to the dealer and displays the first card.
3. If the player has a blackjack, they win and the game displays an appropriate message. Continue to Step 15.
4. If the dealer has a blackjack, the player loses and the game displays an appropriate message. Return to Scenario 3 and continue with Step 6.
5. If both the player and the dealer have a blackjack, the game ends in a tie and displays an appropriate message. Continue to Step 15.
6. If this is the first action of the hand, and the player has enough credits to place an additional bet, the game asks the player if they want to hit, stand, or double down. Otherwise, the game asks the player if they want to hit or stand.
7. The player inputs their selection.
8. If the player chose to stand, their turns ends. Proceed to Step 14.
9. If the player chose to double down, they place an additional bet.
10. The game deals the player a new card and displays their new hand.
11. If the player’s hand totals 21, their turn ends. Proceed to Step 14.
12. If the player’s hand exceeds 21, they bust and the game displays an appropriate message. Return to Scenario 3 and continue with Step 6.
13. Return to Step 6 unless the player doubled down.
14. Follow Scenario 2 for the dealer’s turn. 
15. If the hand ended in a tie, the player retrieves their bet(s). If the player won, they retrieve their bet(s) and win an additional bet, plus an extra bet if they doubled down, or an extra half bet if they won with a blackjack.

Example 4.1, in which the player doubles down and wins the hand:

```
Welcome to Blackjack!
A bet is 50 credits.

You have 500 credits.
Would you like to play a hand?
y
You have 11: 6♣, 5♣.
Dealer has 6♠.
Would you like to (h)it, (s)tand, or (d)ouble down?
d
You have 16: 6♣, 5♣, 5♥.
Dealer reveals J♥.
Dealer draws 10♦.
Dealer has 26: 6♠, J♥, 10♦.
Dealer busts.
You win.

You have 600 credits.
Would you like to play a hand?
n
You've ended the game with 600 credits.
That's 100 credits won!
```

Example 4.2, in which the player doubles down and loses the hand:

```
Welcome to Blackjack!
A bet is 50 credits.

You have 500 credits.
Would you like to play a hand?
y
You have 14: J♥, 4♣.
Dealer has Q♥.
Would you like to (h)it, (s)tand, or (d)ouble down?
d
You have 15: J♥, 4♣, A♣.
Dealer reveals K♥.
Dealer has 20: Q♥, K♥.
You lose.

You have 400 credits.
Would you like to play a hand?
n
You've ended the game with 400 credits.
You've lost 100 credits.
```

### Scenario 5 (iteration 4)

This scenario modifies Scenario 3 to include splitting. Replace Step 5 with the following:

1. The game deals two cards to the player and displays them.
2. The game deals two cards to the dealer and displays the first card.
3. If the player has a blackjack, they win and the game displays an appropriate message. The player retrieves their bet and wins an additional bet, plus an extra half bet. Return to Scenario 3 and continue with Step 6.
4. If the dealer has a blackjack, the player loses and the game displays an appropriate message. Return to Scenario 3 and continue with Step 6.
5. If both the player and the dealer have a blackjack, the game ends in a tie and displays an appropriate message. The player retrieves their bet. Return to Scenario 3 and continue with Step 6.
6. If this is the first action of the hand, and the player’s cards have the same value, and the player has enough credits to place an additional bet, and the player has less than four hands in play, the game asks the player if they want to hit, stand, or split. Otherwise, the game asks the player if they want to hit or stand.
7. The player inputs their selection.
8. If the player chose to stand, their turns ends. Proceed to Step 15.
9. If the player chose to split, they place an additional bet. The game then moves one of the player’s cards to a new hand. For both hands, the game considers the player’s next action their first.
10. The game deals the player a new card and displays their new hand.
11. If the current hand is the result of splitting aces, the player must stand. Proceed to Step 15.
12. If the player’s hand totals 21, their turn ends. Proceed to Step 15.
13. If the player’s hand exceeds 21, they bust and the game displays an appropriate message. Proceed to Step 15.
14. Return to Step 6.
15. If the player has more hands to play because of a split, the game proceeds to the next hand. Return to Step 10.
16. If all of the player’s hands have busted, the player loses. Return to Scenario 3 and continue with Step 6.
17. Follow Scenario 2 for the dealer’s turn.
18. For each hand that didn’t bust, the game displays an appropriate message to inform the player of their result. For each hand that ended in a tie, the player retrieves their bet. For each hand the player won, they retrieve their bet and win an additional bet.

> **Note**: This scenario doesn’t include doubling down to focus on splitting. The implementation of the scenario does include both splitting and doubling down.

Example 5.1, in which the player splits once:

```
Welcome to Blackjack!
A bet is 50 credits.

You have 500 credits.
Would you like to play a hand?
y
You have 20: K♥, 10♣.
Dealer has 9♦.
Would you like to (h)it, (s)tand, or s(p)lit?
p
Hand split. Continuing with the current hand.
You have 20: K♥, Q♥.
Would you like to (h)it, (s)tand, or s(p)lit?
s
Continuing with hand 2.
You have 19: 10♣, 9♠.
Would you like to (h)it or (s)tand?
s
Dealer reveals J♥.
Dealer has 19: 9♦, J♥.
You win hand 1.
Hand 2 ties.

You have 550 credits.
Would you like to play a hand?
n
You've ended the game with 550 credits.
That's 50 credits won!
```

Example 5.2, in which the player splits aces and loses both hands:

```
Welcome to Blackjack!
A bet is 50 credits.

You have 500 credits.
Would you like to play a hand?
y
You have soft 12: A♥, A♠.
Dealer has 8♦.
Would you like to (h)it, (s)tand, or s(p)lit?
p
Splitting aces. Each hand will draw only one additional card.
You have soft 16: A♥, 5♣.
Continuing with hand 2.
You have soft 14: A♠, 3♦.
Dealer reveals 9♠.
Dealer has 17: 8♦, 9♠.
You lose hand 1.
You lose hand 2.

You have 400 credits.
Would you like to play a hand?
n
You've ended the game with 400 credits.
You've lost 100 credits.
```

### Scenario 6 (iteration 4)

This scenario modifies Scenario 1 to include insurance.

1. The game deals two cards to the player and displays them.
2. The game deals two cards to the dealer and displays the first card.
3. If the dealer’s visible card is an ace and the player has enough credits to place an insurance bet, the game asks the player if they want to purchase insurance.
4. If the player confirms, they place an insurance bet (a half bet).
5. If the dealer has a blackjack and the player has insurance, the player retrieves their insurance bet and wins an additional full bet. Otherwise, the insurance bet is lost.
6. Continue with Step 3 from Scenario 1.

Example 6.1, in which the player buys insurance but the dealer doesn’t have a blackjack:

```
Welcome to Blackjack!
A bet is 50 credits.

You have 500 credits.
Would you like to play a hand?
y
You have 13: 6♦, 7♥.
Dealer has A♣.
Would you like to buy insurance?
y
Would you like to (h)it or (s)tand?
h
You have 23: 6♦, 7♥, J♣.
Busted.
You lose.

You have 425 credits.
Would you like to play a hand?
n
You've ended the game with 425 credits.
You've lost 75 credits.
```

Example 6.2, in which the player buys insurance and the dealer has a blackjack:

```
Welcome to Blackjack!
A bet is 50 credits.

You have 500 credits.
Would you like to play a hand?
y
You have 13: 5♠, 8♥.
Dealer has A♥.
Would you like to buy insurance?
y
Dealer has blackjack: A♥, K♠.
You lose.

You have 500 credits.
Would you like to play a hand?
n
You've ended the game with 500 credits.
```
