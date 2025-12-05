enum Player: String {

    case o = "O"
    case x = "X"

    mutating func toggle() {
        if self == .o {
            self = .x
        } else {
            self = .o
        }
    }

    static func random() -> Player {
        Bool.random() ? .o : .x
    }
}
