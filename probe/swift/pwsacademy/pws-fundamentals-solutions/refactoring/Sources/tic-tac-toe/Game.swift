struct Game {

    private var board: Board
    private var currentPlayer: String
    private var isOver: Bool

    init() {
        board = Board()
        currentPlayer = Bool.random() ? "O" : "X"
        isOver = false
    }

    mutating func play() {
        while !isOver {
            board.print()
            print()
            takeTurn()
            print()
            if !board.isFull && !currentPlayerHasWon() {
                currentPlayer = currentPlayer == "O" ? "X" : "O"
            } else {
                isOver = true
            }
        }
        board.print()
        print()
        if currentPlayerHasWon() {
            print("Player \(currentPlayer) has won!")
        } else {
            print("The game has ended in a tie.")
        }
    }

    private mutating func takeTurn() {
        print("Player \(currentPlayer), it's your turn.")
        let selectedPosition = Input.readPosition(on: board)
        board.setPosition(selectedPosition, to: currentPlayer)
    }
    
    private func currentPlayerHasWon() -> Bool {
        let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8],  // rows
                                   [0, 3, 6], [1, 4, 7], [2, 5, 8],  // columns
                                   [0, 4, 8], [2, 4, 6]]  // diagonals
        return winningCombinations.contains {
            $0.map { board.positions[$0] } == [currentPlayer, currentPlayer, currentPlayer]
        }
    }
}
