/*
 The game board is stored as nine variables of type String.
 Each variable stores either the player symbol "O" or "X", or its position number,
 to indicate that the position is available.
 */
var topLeft = "1"
var top = "2"
var topRight = "3"
var left = "4"
var center = "5"
var right = "6"
var bottomLeft = "7"
var bottom = "8"
var bottomRight = "9"

/*
 Prints the board.
 Columns are separated using pipes (|).
 Rows are separated using dashes (-).
 */
func printBoard() {
    print("""
           \(topLeft) | \(top) | \(topRight)
          -----------
           \(left) | \(center) | \(right)
          -----------
           \(bottomLeft) | \(bottom) | \(bottomRight)
          """)
}

/*
 Checks if the board is full.
 The board is full when none of the nine variables holds its initial (number) value.
 */
func boardIsFull() -> Bool {
    topLeft != "1" &&
    top != "2" &&
    topRight != "3" &&
    left != "4" &&
    center != "5" &&
    right != "6" &&
    bottomLeft != "7" &&
    bottom != "8" &&
    bottomRight != "9"
}

/*
 Resets the board by assigning each of the nine variables its initial (number) value.
 */
func resetBoard() {
    topLeft = "1"
    top = "2"
    topRight = "3"
    left = "4"
    center = "5"
    right = "6"
    bottomLeft = "7"
    bottom = "8"
    bottomRight = "9"
}
