var roll = Roll()
print("You rolled: \(roll)")
while roll.remainingRerolls > 0 {
  if !Input.playerWantsToReroll() {
    break
  }
  let reservedDice = Input.selectDiceToReserve()
  roll.reroll(reserving: reservedDice)
  print("You rolled: \(roll)")
}
