# Design for Yahtzee

This is a design document for Challenge 3: “Yahtzee”. It builds on the requirements and scenarios from the analysis document, so read that first if you haven’t already done so.

This design follows the iterations suggested in the challenge. For each iteration, it contains an outline of the scenarios for that iteration and a list of suggested types and members. Your design may be different, but it should contain approximately the same information.

## Iteration 1

Here’s an outline for Scenario 1:

```
roll dice
print roll
while player has rerolls {
  if player wants reroll {
    select dice to reserve
    reroll unreserved dice
    print roll
  } else {
    break
  }
}
```

From this outline, you can identify two types. The first is the familiar `Input` type. It has two methods that request input from the current player:

```swift
enum Input {

  static func playerWantsToReroll() -> Bool
  static func selectDiceToReserve() -> [Int]
}
```

Next, you need to store the values of the dice and the number of rerolls, and you need a way to roll and reroll the dice. For this, you can declare a type `Roll`:

```swift
struct Roll {

  private(set) var dice: [Int]
  private(set) var remainingRerolls: Int

  init()
  mutating func reroll(reserving reservedDice: [Int])
}
```

Here, the initializer creates a roll and rolls the dice. The `dice` and `remainingRerolls` properties are read-only so you can’t change them directly; you have to use the `reroll` method.

The last thing you need to implement the outline is a way to print a roll. For this, you can conform `Roll` to `CustomStringConvertible`.

## Iteration 2

Here’s an outline for Scenario 2:

```
print card
roll dice
print roll
while player has rerolls {
  if player can score roll && player declines reroll {
    break
  }
  select dice to reserve
  reroll unreserved dice
  print roll
}
if last turn {
  assign roll to last empty field
} else {
  ask player to select an empty field
  assign roll to selected field
}
```

To implement this outline, you first have to decide how you want to represent a score card and the fields on that card.

Although you can represent the fields as numbers (1 through 13), a better design is to use an enumerated type. That way, you can declare the fields by name and refer to them in a type-safe manner:

```swift
enum Field {

  case ones
  case twos
  case threes
  case fours
  case fives
  case sixes
  case threeOfAKind
  case fourOfAKind
  case fullHouse
  case smallStraight
  case largeStraight
  case chance
  case yahtzee
}
```

However, the fields have a fixed order, which you don’t want to lose. Fortunately, you can use `Int` as a raw type so you can still refer to the fields by number:

```swift
enum Field: Int {
        
  case ones = 1
  case twos
  case threes
  case fours
  case fives
  case sixes
  case threeOfAKind
  case fourOfAKind
  case fullHouse
  case smallStraight
  case largeStraight
  case chance
  case yahtzee
}
```

You can also add `CaseIterable` conformance; the `allCases` property will return the fields in the order you’ve declared them:

```swift
enum Field: Int, CaseIterable {

  case ones = 1
  // ...
}

Field.allCases
```

Each field has its own algorithm for scoring the roll you assign to it. You can implement these algorithms in a method on `Field`:

```swift
func value(of roll: Roll) -> Int
```

Next, you need a type `ScoreCard`. This type can use a dictionary to track the score for each field:

```swift
struct ScoreCard {

  private var scoredFields: [Field: Int]
}
```

You can also add an `emptyFields` property:

```swift
struct ScoreCard {

  private var scoredFields: [Field: Int]
  private var emptyFields: [Field]
}
```

This can be a computed property that uses `Field.allCases` and `scoredFields` to determine which fields are empty.

In addition to these properties, `ScoreCard` also needs a few methods:

```swift
struct ScoreCard {

  private var scoredFields: [Field: Int]
  private var emptyFields: [Field]

  func canScore(_ roll: Roll) -> Bool
  func scores(for roll: Roll) -> [Field: Int]
  mutating func assign(_ roll: Roll, to field: Field)
}

extension ScoreCard: CustomStringConvertible
```

Here’s what these method do:

* `canScore(_:)` checks if a roll is worth any points for any of the empty fields.
* `scores(for:)` returns the score a roll would get for each of the empty fields.
* `assign(_:to:)` scores a field.

Finally, `CustomStringConvertible` conformance makes it easy to print a card.

With these new types, you can implement most of the outline, except for `ask player to select an empty field`. To implement this statement, you can add the following method to `Input`:

```swift
static func selectField(from options: [ScoreCard.Field: Int]) -> ScoreCard.Field
```

As you can tell from this method, I chose to nest `Field` within `ScoreCard`. This doesn’t add any encapsulation because `Field` isn’t private, but it does make the relationship between the two types explicit.

## Iteration 3

Here’s an outline for Scenarios 3 and 4:

```
repeat 13 times {
  print card
  roll dice
  rerolls: while true {
    print roll
    if roll is joker {
      break rerolls
    }
    if no remaining rerolls {
      break rerolls
    }
    if player can score roll && player declines reroll {
      break rerolls
    }
    select dice to reserve
    reroll unreserved dice
  }
  if last turn {
    assign roll to last empty field
  } else {
    ask player to select an empty field
    assign roll to selected field
  }
}
print final score
```

To implement `if roll is joker`, you need a method that checks if the player’s roll results in a joker. This method belongs in `ScoreCard` because you need to check the Yahtzee field to determine whether a Yahtzee roll results in a joker:

```swift
func givesJoker(_ roll: Roll) -> Bool
```

Once you’ve determined this, you can store the result in a property on `Roll`:

```swift
var isJoker: Bool
```

You can then use this property to determine the value of a roll when scoring it.

Next, you need properties on `ScoreCard` to track the number of bonus Yahtzees the player has rolled, and to calculate the upper section bonus:

```swift
private var bonusYahtzees: Int
private var threeOfEachBonus: Int
```

You can then use these properties to calculate the player’s total score:

```swift
var total: Int
```

## Iteration 4

Here’s an outline for Scenario 5:

```
read number of players
read player names
repeat 13 times {
  for each player {
    print player name
    play turn
    go to next player
  }
}
print results
print ranking
```

The first two statements require new input methods:

```swift
static func askNumberOfPlayers() -> Int
static func askName(forPlayerNumber number: Int) -> String
```

Next, you need a type to represent a player. Each player has a name and a score card:

```swift
struct Player {

  let name: String
  var card: ScoreCard
}
```

You also need an array to store the players:

```swift
var players: [Player]
```

You now have everything you need to implement the outline. However, I don’t recommend you stop here.

With the current design, you’ll have a lot of code in **main.swift**, which is undesirable. You can improve your design by introducing a `Game` type and moving most of the code from **main.swift** into that type.

A `Game` stores its players and provides a `play` method that runs the main loop:

```swift
struct Game {

  private var players: [Player]

  init(numberOfPlayers: Int)
  mutating func play()
}
```

You can improve this even more by moving parts of the `play` function, such as the code that performs a single turn, or the code that prints the results, into helper functions:

```swift
struct Game {

  private var players: [Player]

  init(numberOfPlayers: Int)
  mutating func play()

  private mutating func doTurn(forPlayerNumber index: Int)
  private func printResults()
}
```
