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
