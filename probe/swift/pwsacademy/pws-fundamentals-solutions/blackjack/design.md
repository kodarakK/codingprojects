# Design for Blackjack

This is a design document for Challenge 2: “Blackjack”. It’s based on the requirements and scenarios from the analysis document, so read that first if you haven’t already done so.

This design follows the iterations suggested in the challenge. For each iteration, it contains an outline of the scenarios for that iteration and a list of suggested variables and functions. Your design may be different, but it should contain approximately the same information.

## Iteration 1

Here’s an outline for Scenario 1. This outline uses pseudocode that’s close to English, so you can easily see how the outline relates to the scenario:

```
add card to player's hand
add card to player's hand
print player's hand
add card to dealer's hand
add card to dealer's hand
print dealer's first card

if dealer's hand == 21 {
  if player's hand == 21 {
    print("It's a tie.")
  } else {
    print("You lose.")
  }
} else if player's hand == 21 {
  print("You win.")
} else {
  while player's hand < 21 {
    print("Would you like to (h)it or (s)tand?")
    if player stands {
      break
    }
    add card to player's hand
    print player's hand
  }
  if player's hand > 21 {
    print("Busted.")
  }
}
```

Next, consider each statement in this outline to identify the variables and functions you need to implement it.

First, consider the statement `add card to player's hand`. You can learn quite a lot from this statement alone. Here’s what you need to implement it:

- A type to represent a card.
- A type to represent a hand of cards.
- A function to draw a card from the deck.
- A function to add a card to a hand.
- A variable to store the player’s hand.

A card is a combination of a rank and a suit. Therefore, you can use the following tuple to represent a card:

```swift
(rank: String, suit: String)
```

You can declare a type alias for this tuple to improve the clarity and readability of your code:

```swift
typealias Card = (rank: String, suit: String)
```

You can do the same for a hand, which is an array of cards:

```swift
typealias Hand = [Card]
```

To draw a card from the deck, you can declare the following function:

```swift
func draw() -> Card 
```

This function removes a card from the deck and returns it. To implement it, you also need a variable to store the deck, and a function to initialize it:

```swift
var deck: [Card]
func initializeDeck()
```

To add a card to a hand, you can use the `append` method of type `Array`. You don’t need a new function for this:

```swift
hand.append(card)
```

Finally, you can declare the following variable to store the player’s hand:

```swift
var playerHand: Hand
```

To implement the similar statement `add card to dealer's hand`, you also need a variable to store the dealer’s hand:

```swift
var dealerHand: Hand
```

Next, consider the statements `print player's hand` and `print dealer's first card`. To implement these statement, you need functions that return a string for either a hand of cards, or a single card:

```swift
func description(for hand: Hand) -> String
func description(for card: Card) -> String
```

You can then use these strings in string interpolation. For example:

```swift
print("You have \(description(for: playerHand)).")
```

The control flow statements, such as `if dealer's hand == 21` and `while player's hand < 21`, all rely on the value of a hand. You need a function to calculate this value:

```swift
func value(for hand: Hand) -> (value: Int, isSoft: Bool)
```

This function returns both the value of the hand, and whether that value is soft. To implement it, you need to know the value of each rank. These values are static, so you can store them in a dictionary:

```swift
let values: [String: Int]
```

Finally, consider the statement `if player stands`. To implement this function, you need to ask the player whether they want to hit or stand. You can use the following function to ask the player to select from one of the given options:

```swift
func one(of options: [String]) -> String
```

This function reads input from the player and makes sure that input is valid. If not, it asks for new input until the player inputs one of the given options.

## Iteration 2

Here’s an outline for Scenario 2:

```
print dealer's second card
while dealer's hand < 17 || dealer's hand == soft 17 {
  add card to dealer's hand
  print card
}
print dealer's hand
if dealer's hand > 21 {
  print("Dealer busts.\nYou win.")
} else if player's hand > dealer's hand {
  print("You win.")
} else if player's hand < dealer's hand {
  print("You lose.")
} else {
  print("It's a tie.")
}
```

This outline doesn’t require any new variables or functions.

## Iteration 3

Here’s an outline for Scenario 3:

```
print welcome message
credits = 500
while credits >= bet {
  print credits
  print("Would you like to play a hand?")
  if player confirms {
    credits -= bet
    play a hand
  } else {
    break
  }
}
print credits
if credits > initialCredits {
  print credits won
} else if credits < initialCredits {
  print credits lost
}
```

First, consider the statement `print welcome message`. This welcome message includes the bet size, which is a fixed number. However, as you can tell from the rest of the outline, you use this number in multiple places. Therefore, you should declare it as a constant:

```swift
let bet = 50
```

Now, when you decide to change the size of a bet, you only have to change it in a single location. Using a constant also improves the clarity of your code. A descriptive name (`bet`) conveys more meaning than a number (50).

Next, consider the statement `credits = 500`. This tells you you need a variable to store the number of credits the player has:

```swift
var credits = 500
```

This variable has an initial value of 500. However, this isn’t the only place you use this number. Statements such as `if credits > initialCredits` also refer to it. Therefore, it’s better to declare a constant for this number as well:

```swift
let initialCredits = 500
var credits = initialCredits
```

Next, consider the statement `if player confirms`. This statement reads a yes/no response from the player. Although you can implement it using the `one(of:)` function, you can improve the readability of the code by declaring a new function:

```swift
func playerConfirms() -> Bool
```

Finally, there’s the `play a hand` statement. Other than paying out bets, this statement encapsulates the code from the previous iterations. You can move this code into a function:

```swift
func play()
```

However, the `play` function has grown rather large and complex and it’ll become even more complex when you add to it in the next iteration. For this reason, the implementation moves parts of the `play` function into helper functions such as `doPlayerTurn` and `payOut`. This is a good way to improve the current iteration and prepare for the next one.

## Iteration 4

### Scenario 4

Doubling down affects only the `doPlayerTurn` and `payOut` functions. Here are new outlines for these functions:

`doPlayerTurn`:

```
while player's hand < 21 {
  if first action && credits >= bet {
    print("Would you like to (h)it, (s)tand, or (d)ouble down?")
  } else {
    print("Would you like to (h)it or (s)tand?")
  }
  if player stands {
    break
  }
  add card to player's hand
  print player's hand
  if player doubles down {
    credits -= bet
    break
  }
}
```

`payOut`:

```
if dealer's hand > 21 {
  print("Dealer busts.\nYou win.")
  if doubled down {
    credits += 4 * bet
  } else {
    credits += 2 * bet
  }
} else if player's hand > dealer's hand {
  print("You win.")
  if doubled down {
    credits += 4 * bet
  } else {
    credits += 2 * bet
  }
} else if player's hand < dealer's hand {
  print("You lose.")
} else {
  print("It's a tie.")
  if doubled down {
    credits += 2 * bet
  } else {
    credits += bet
  }
}
```

You need two additional variables to implement these outlines. First, you need a variable to track whether this is the player’s first action of the hand:

```swift
var firstAction: Bool
```

You only use this variable in `doPlayerTurn` so it can be a local variable in that function.

Next, you need a variable to track whether the player has doubled down:

```swift
var playerHasDoubledDown: Bool
```

You’ll set this variable in `doPlayerTurn` and read it in `payOut`, so it must be global variable.

### Scenario 5

First consider the `play` function. Now that the player can have multiple hands, you only skip the dealer’s turn if all of the player’s hands have busted.

Here’s an outline:

```
initialize hand
check for dealer blackjack
check for player blackjack
do player's turn
if all hands busted {
  print("You lose.")
  return
}
do dealer's turn
pay out
```

Compared to the previous iteration, only the statement `if all hands busted` has changed. You can declare the following function to help you implement this statement:

```swift
func allHandsBusted() -> Bool
```

Next, consider `doPlayerTurn`. Here’s a new outline for this function:

```
for every hand {
  if not first hand {
    add card to player's hand
    print player's hand
    if player split aces {
      continue to next hand
    }
  }
  while player's hand < 21 {
    if first action && player can split hand && credits >= bet {
      print("Would you like to (h)it, (s)tand, s(p)lit, or (d)ouble down?")
    } else if first action && credits >= bet {
      print("Would you like to (h)it, (s)tand, or (d)ouble down?")
    } else {
      print("Would you like to (h)it or (s)tand?")
    }
    if player stands {
      continue to next hand
    }
    if player splits {
      credits -= bet
      move one card to new hand
      if player split aces {
        add card to player's hand
        print player's hand
        continue to next hand
      }
    }
    add card to player's hand
    print player's hand
    if player's hand > 21 {
      print("Busted.")
    }
    if player doubles down {
      credits -= bet
      continue to next hand
    }
  }
}
```

To implement this outline, you first need to change `playerHand` to an array so that you can store multiple hands:

```swift
var playerHands: [Hand]
```

You also need to track what hand you’re on:

```swift
var currentHand: Int
```

With these variables, you can now implement statements such as `for every hand`, `if not first hand`, and `continue to next hand`.

Next, consider the statement `if player split aces`. This checks the rank of the split cards. You don’t need anything new to implement it.

However, the condition `player can split` is more complicated. It checks whether the player’s cards have the same value, and if the player has less than four hands in play. You can declare a function to perform this check:

```swift
func playerCanSplit() -> Bool
```

Next, consider the statement `move one card to new hand`. To move a card, you remove it from one hand and add it to another. You can implement this using the `removeLast` and `append` methods of type `Array`.

Lastly, to implement doubling down, you need to change `playerHasDoubledDown` to an array so you can store a value for each hand:

```swift
var playerHasDoubledDown: [Bool]
```

Finally, consider the `payOut` function. Here’s a new outline:

```
for every hand that didn't bust {
  if dealer's hand > 21 || player's hand > dealer's hand {
    print("You win.")
    if doubled down {
      credits += 4 * bet
    } else {
      credits += 2 * bet
    }
  } else if player's hand < dealer's hand {
    print("You lose.")
  } else {
    print("It's a tie.")
    if doubled down {
      credits += 2 * bet
    } else {
      credits += bet
    }
  }
}
```

You don’t need anything new to implement this outline. It simply repeats the steps from the previous version for every hand that didn’t bust.

### Scenario 6

Here’s a new outline for the `play` function that includes insurance:

```
initialize hand
ask for insurance
check for dealer blackjack
check for player blackjack
do player's turn
if all hands busted {
  print("You lose.")
  return
}
do dealer's turn
pay out
```

Compared to the previous iteration, the only change is the addition of an `ask for insurance` statement. You can declare the following function to implement this statement:

```swift
func askForInsurance()
```

Here’s an outline for this function:

```
if dealer has ace && credits >= bet / 2 {
  print("Would you like to buy insurance?")
  if player confirms {
    credits -= bet / 2
  }
}
```

You don’t need anything new to implement this outline. You only need a variable to store whether the player bought insurance or not:

```swift
var playerHasInsurance: Bool
```

You’ll use this variable in the `dealerHasBlackjack` function. Here’s a new outline for this function:

```
if dealer's hand != 21 {
  return false
}
print dealer's hand
if player has insurance {
  credits += 3 * bet / 2
}
if player's hand == 21 {
  print("It's a tie.")
  credits += bet
} else {
  print("You lose.")
}
return true
```
