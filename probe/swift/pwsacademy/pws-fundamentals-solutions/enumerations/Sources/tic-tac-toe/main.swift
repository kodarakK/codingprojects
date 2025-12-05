print("Welcome to Tic-Tac-Toe!")
repeat {
    print()
    var game = Game()
    game.play()
} while Input.readBool(question: "Would you like to play again?")
