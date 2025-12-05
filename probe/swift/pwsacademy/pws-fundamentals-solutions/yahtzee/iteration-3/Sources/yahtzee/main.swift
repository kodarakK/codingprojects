var card = ScoreCard()

for _ in 1...13 {
    print("Your score card:\n\(card)")
    var roll = Roll()
    rerolls: while true {
        // This loop relies solely on break statements for loop control.
        // This is because it checks the conditions halfway through each iteration,
        // and not at the beginning or the end.
        print("You rolled: \(roll)")
        if card.givesJoker(roll) {
            print("Yahtzee! You can use this roll as a joker.")
            roll.isJoker = true
            break rerolls
        }
        if roll.remainingRerolls == 0 {
            break rerolls
        }
        if card.canScore(roll) && !Input.playerWantsToReroll() {
            break rerolls
        }
        let reservedDice = Input.selectDiceToReserve()
        roll.reroll(reserving: reservedDice)
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
    print("")
}

print("Your final score:\n\(card)")
