/*
 Type `Input` doesn't need any instances so it can be a caseless enumeration.
 */
enum Input {

    /*
     Reads input until a match is found with one of the given actions.
     */
    static func one(of actions: [Action]) -> Action {
        while true {  // Loop until the user inputs one of the actions.
            let input = readLine()!.lowercased()
            if let action = Action(from: input), actions.contains(action) {
                return action
            }
        }
    }

    /*
     Reads a yes/no response.
     */
    static func playerConfirms() -> Bool {
        let answer = one(of: [.yes, .no])
        return answer == .yes
    }
}
