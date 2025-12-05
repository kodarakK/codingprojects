/// A game of Yahtzee.
struct Game {

    /// The game's players.
    private var players: [Player] = []

    /// Initializes a game with the given number of players.
    ///
    /// - Parameter numberOfPlayers: must be at least 1.
    init(numberOfPlayers: Int) {
        for number in 1...numberOfPlayers {
            var name = Input.askName(forPlayerNumber: number)
            let playersWithSameName = players.count { $0.name == name }
            if playersWithSameName > 0 {
                name.append(" #\(playersWithSameName + 1)")
            }
            players.append(Player(name: name))
        }
        print("")
    }

    /// Plays a full game of Yahtzee, with 13 turns for each player, then prints the results.
    ///
    /// You can only call this method once. Create a new instance if you want to play a new game.
    mutating func play() {
        for _ in 1...13 {
            for index in players.indices {
                doTurn(forPlayerNumber: index)
            }
        }
        printResults()
    }
    
    /// Plays a single turn for one player.
    private mutating func doTurn(forPlayerNumber index: Int) {
        print("\(players[index].name), it's your turn.")
        print("Your score card:\n\(players[index].card)\n")
        var roll = Roll()
        rerolls: while true {
            // This loop relies solely on break statements for loop control.
            // This is because it checks the conditions halfway through each iteration,
            // and not at the beginning or the end.
            print("You rolled: \(roll)")
            if players[index].card.givesJoker(roll) {
                print("Yahtzee! You can use this roll as a joker.")
                roll.isJoker = true
                break rerolls
            }
            if roll.remainingRerolls == 0 {
                break rerolls
            }
            if players[index].card.canScore(roll) && !Input.playerWantsToReroll() {
                break rerolls
            }
            let reservedDice = Input.selectDiceToReserve()
            roll.reroll(reserving: reservedDice)
        }
        let options = players[index].card.scores(for: roll)
        let selection: ScoreCard.Field
        if options.count == 1 {
            selection = options.first!.key
            print("Automatically assigned to \(selection).")
        } else {
            selection = Input.selectField(from: options)
        }
        players[index].card.assign(roll, to: selection)
        print("")
    }

    /// Prints the results and ranking.
    private func printResults() {
        print("Results:\n")
        var results: [Player: Int] = [:]
        for player in players {
            print("\(player.name):\n\(player.card)\n")
            results[player] = player.card.total
        }
        print("Ranking:\n")
        let ranking = results.sorted(by: { $0.value > $1.value })
        for (index, (player, score)) in ranking.enumerated() {
            print("\(index + 1). \(player.name): \(score)")
        }
    }
}
