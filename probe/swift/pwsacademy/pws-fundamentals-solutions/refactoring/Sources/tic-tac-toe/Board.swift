struct Board {

    private(set) var positions: [String?]

    init() {
        positions = Array(repeating: nil, count: 9)
    }

    var isFull: Bool {
        positions.allSatisfy { $0 != nil }
    }

    mutating func setPosition(_ position: Int, to player: String) {
        positions[position] = player
    }

    mutating func reset() {
        positions = Array(repeating: nil, count: 9)
    }
    
    func print() {
        Swift.print("""
            \(positions[0] ?? "1") | \(positions[1] ?? "2") | \(positions[2] ?? "3")
            -----------
            \(positions[3] ?? "4") | \(positions[4] ?? "5") | \(positions[5] ?? "6")
            -----------
            \(positions[6] ?? "7") | \(positions[7] ?? "8") | \(positions[8] ?? "9")
            """)
    }
}
