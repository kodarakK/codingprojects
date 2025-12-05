/*
 Reads input until a match is found with one of the provided options.
 */
func one(of options: [String]) -> String {
    var answer: String
    repeat {
        answer = readLine()!.lowercased()
    } while !options.contains(answer)
    return answer
}

/*
 Reads a yes/no response.
 */
func playerConfirms() -> Bool {
    let answer = one(of: ["y", "yes", "n", "no"])
    return ["y", "yes"].contains(answer)
}
