enum Input {

    static func readPosition(on board: Board) -> Int {
        print("Select a position (1-9): ", terminator: "")
        while true {  // Loop until the user enters a valid and empty position.
            let input = readLine()!
            if let position = Int(input) {
                if position < 1 || position > 9 {
                    print("Please enter a number between 1 and 9.")
                    continue
                }
                if board.positions[position - 1] != nil {
                    print("This position is already claimed. Please select an empty position.")
                    continue
                }
                return position - 1
            } else {
                print("Please enter a number.")
            }
        }
    }

    static func readBool(question: String) -> Bool {
        var answer: String
        repeat {
            print("\(question) (y/n): ", terminator: "")
            answer = readLine()!
        } while answer != "y" && answer != "n"
        return answer == "y"
    }
}
