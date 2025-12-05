/*
 The possible actions a player can select.
 */
enum Action {

    case hit
    case stand
    case double
    case split
    case yes
    case no

    /*
     Initializes an action from the user's input.
     Returns `nil` if the input doesn't match any of the actions.
     */
    init?(from input: String) {
        switch input.lowercased() {
        case "h", "hit":
            self = .hit
        case "s", "stand":
            self = .stand
        case "d", "double":
            self = .double
        case "p", "split":
            self = .split
        case "y", "yes":
            self = .yes
        case "n", "no":
            self = .no
        default:
            return nil
        }
    }

    /*
     Returns the expected input (a word or a letter) for this action.
     */
    var description: String {
        switch self {
        case .hit: "(h)it"
        case .stand: "(s)tand"
        case .double: "(d)ouble"
        case .split: "s(p)lit"
        case .yes: "(y)es"
        case .no: "(n)o"
        }
    }
}
