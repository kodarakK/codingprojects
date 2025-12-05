/*
 The current player ("O" or "X").
 */
var currentPlayer = ""  // initializeGame will set a random starting player.

/*
 The most recently selected position.
 Storing this value simplifies currentPlayerHasWon.
 */
var selectedPosition = 0

/*
 Whether the game is over.
 The game is over if the board is full or the current player makes three-in-a-row.
 */
var gameIsOver = false

/*
 Plays a complete game.
 */
func playGame() {
    initializeGame()
    while !gameIsOver {
        printBoard()
        print()
        takeTurn()
        print()
        if !boardIsFull() && !currentPlayerHasWon() {
            switchPlayers()
        } else {
            gameIsOver = true
            // Don't switch players when the game is over, so currentPlayer remains the winner.
        }
    }
    printBoard()
    print()
    if currentPlayerHasWon() {
        print("Player \(currentPlayer) has won!")
    } else {
        print("The game has ended in a tie.")
    }
}

/*
 Initializes the game.
 This resets the board and selects a random starting player.
*/
func initializeGame() {
    resetBoard()
    currentPlayer = Bool.random() ? "O" : "X"
    gameIsOver = false
}

/*
 Lets the current player take a turn.
 The player is asked to select a position, which is then marked on the board.
 */
func takeTurn() {
    print("Player \(currentPlayer), it's your turn.")
    selectedPosition = readPosition()
    switch selectedPosition {
    case 1:
        topLeft = currentPlayer
    case 2:
        top = currentPlayer
    case 3:
        topRight = currentPlayer
    case 4:
        left = currentPlayer
    case 5:
        center = currentPlayer
    case 6:
        right = currentPlayer
    case 7:
        bottomLeft = currentPlayer
    case 8:
        bottom = currentPlayer
    case 9:
        bottomRight = currentPlayer
    default:
        // This should never happen.
        fatalError("Invalid position returned from readPosition.")
    }
}

/*
 Switches currentPlayer to the other player.
 */
func switchPlayers() {
    if currentPlayer == "O" {
        currentPlayer = "X"
    } else {
        currentPlayer = "O"
    }
}

/*
 Checks if the current player has won the game.
 Knowing the player has just claimed selectedPosition, this function checks
 which other positions the player needs to have claimed to form three-in-a-row.
 */
func currentPlayerHasWon() -> Bool {
    switch selectedPosition {
    case 1:
        return top == currentPlayer && topRight == currentPlayer  // top row
            || center == currentPlayer && bottomRight == currentPlayer  // diagonal
            || left == currentPlayer && bottomLeft == currentPlayer  // left column
    case 2:
        return topLeft == currentPlayer && topRight == currentPlayer  // top row
            || center == currentPlayer && bottom == currentPlayer  // center column
    case 3:
        return topLeft == currentPlayer && top == currentPlayer  // top row
            || center == currentPlayer && bottomLeft == currentPlayer  // diagonal
            || right == currentPlayer && bottomRight == currentPlayer  // right column
    case 4:
        return topLeft == currentPlayer && bottomLeft == currentPlayer  // left column
            || center == currentPlayer && right == currentPlayer  // center row
    case 5:
        return topLeft == currentPlayer && bottomRight == currentPlayer  // diagonal
            || topRight == currentPlayer && bottomLeft == currentPlayer  // diagonal
            || left == currentPlayer && right == currentPlayer  // center row
            || top == currentPlayer && bottom == currentPlayer  // center column
    case 6:
        return topRight == currentPlayer && bottomRight == currentPlayer  // right column
            || left == currentPlayer && center == currentPlayer  // center row
    case 7:
        return topLeft == currentPlayer && left == currentPlayer  // left column
            || center == currentPlayer && topRight == currentPlayer  // diagonal
            || bottom == currentPlayer && bottomRight == currentPlayer  // bottom row
    case 8:
        return bottomLeft == currentPlayer && bottomRight == currentPlayer  // bottom row
            || top == currentPlayer && center == currentPlayer  // center column
    case 9:
        return bottomLeft == currentPlayer && bottom == currentPlayer  // bottom row
            || topLeft == currentPlayer && center == currentPlayer  // diagonal
            || topRight == currentPlayer && right == currentPlayer  // right column
    default:
        // This should never happen.
        fatalError("Invalid value for selectedPosition.")
    }
}
