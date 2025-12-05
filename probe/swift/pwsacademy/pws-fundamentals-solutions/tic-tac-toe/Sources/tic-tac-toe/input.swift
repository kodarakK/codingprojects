/*
 Asks the user for a position between 1 and 9, and returns this value.
 This function will repeatedly ask for a position, until the user enters a valid, empty position.
 */
func readPosition() -> Int {
    var position: Int
    repeat {
        print("Select a position (1-9): ", terminator: "")
        let input = readLine()!
        position = Int(input)!  // Caution: This will crash if the user didn't enter a number!
        // Check if the position is empty.
        var valueAtPosition: String
        switch position {
        case 1:
            valueAtPosition = topLeft
        case 2:
            valueAtPosition = top
        case 3:
            valueAtPosition = topRight
        case 4:
            valueAtPosition = left
        case 5:
            valueAtPosition = center
        case 6:
            valueAtPosition = right
        case 7:
            valueAtPosition = bottomLeft
        case 8:
            valueAtPosition = bottom
        case 9:
            valueAtPosition = bottomRight
        default:
            continue  // Invalid position, so read a new number.
        }
        if valueAtPosition == "O" || valueAtPosition == "X" {
            print("This position is already claimed.")
            position = -1  // Set position to an invalid number so the loop will repeat.
        }
    } while position < 1 || position > 9
    return position
}

/*
 Asks the user a yes/no question and returns the result as a Bool.
 */
func readBool(question: String) -> Bool {
    var answer: String
    repeat {
        print("\(question) (y/n): ", terminator: "")
        answer = readLine()!
    } while answer != "y" && answer != "n"
    return answer == "y"
}
