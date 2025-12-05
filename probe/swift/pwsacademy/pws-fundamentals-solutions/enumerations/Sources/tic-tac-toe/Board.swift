struct Board {

    private(set) var positions: [Player?]

    init() {
        positions = Array(repeating: nil, count: 9)
    }

    var isFull: Bool {
        positions.allSatisfy { $0 != nil }
    }

    mutating func setPosition(_ position: Int, to player: Player) {
        positions[position] = player
    }

    mutating func reset() {
        positions = Array(repeating: nil, count: 9)
    }
    
    func print() {
        Swift.print("""
            \(value(at: 0)) | \(value(at: 1)) | \(value(at: 2))
            -----------
            \(value(at: 3)) | \(value(at: 4)) | \(value(at: 5))
            -----------
            \(value(at: 6)) | \(value(at: 7)) | \(value(at: 8))
            """)
    }

    private func value(at position: Int) -> String {
        if let player = positions[position] {
            player.rawValue
        } else {
            "\(position + 1)"
        }
    }
}
