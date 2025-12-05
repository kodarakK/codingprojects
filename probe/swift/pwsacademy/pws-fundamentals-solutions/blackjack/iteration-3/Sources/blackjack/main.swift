print("""
      Welcome to Blackjack!
      A bet is \(bet) credits.

      """)
while credits >= bet {
    print("""
          You have \(credits) credits.
          Would you like to play a hand?
          """)
    if !playerConfirms() {
        break
    }
    credits -= bet
    play()
    print("")
}
print("You've ended the game with \(credits) credits.")
if credits > initialCredits {
    print("That's \(credits - initialCredits) credits won!")
} else if credits < initialCredits {
    print("You've lost \(initialCredits - credits) credits.")
}
