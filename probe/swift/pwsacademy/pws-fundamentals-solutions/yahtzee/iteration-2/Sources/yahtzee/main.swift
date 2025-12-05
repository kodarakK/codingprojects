var card = ScoreCard()
print("Your score card:\n\(card)")

var roll = Roll()
print("You rolled: \(roll)")
while roll.remainingRerolls > 0 {
    if card.canScore(roll) && !Input.playerWantsToReroll() {
        break
    }
    let reservedDice = Input.selectDiceToReserve()
    roll.reroll(reserving: reservedDice)
    print("You rolled: \(roll)")
}

let options = card.scores(for: roll)
let selection: ScoreCard.Field
if options.count == 1 {
    selection = options.first!.key
    print("Automatically assigned to \(selection).")
} else {
    selection = Input.selectField(from: options)
}
card.assign(roll, to: selection)

// To fully test this code, wrap all but the first statement in a `for _ in 1...13` loop so you can play a full game.
