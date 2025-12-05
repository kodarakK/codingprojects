var game = Game()
print("""
      Welcome to Blackjack!
      A bet is \(Game.bet) credits.

      """)
while game.player.credits >= Game.bet {
    print("""
          You have \(game.player.credits) credits.
          Would you like to play a hand?
          """)
    if !Input.playerConfirms() {
        break
    }
    game.player.credits -= Game.bet
    game.play()
    print("")
}
print("You've ended the game with \(game.player.credits) credits.")
if game.player.credits > Game.initialCredits {
    print("That's \(game.player.credits - Game.initialCredits) credits won!")
} else if game.player.credits < Game.initialCredits {
    print("You've lost \(Game.initialCredits - game.player.credits) credits.")
}
