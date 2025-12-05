typealias Person = (name: String, age: Int, favoriteFood: String?)

var people: [Person] = [
    (name: "Alice", age: 19, favoriteFood: "Chocolate"),
    (name: "Bob", age: 32, favoriteFood: "Pizza"),
    (name: "Charlie", age: 16, favoriteFood: nil),
    (name: "David", age: 24, favoriteFood: "Pasta"),
    (name: "Elise", age: 17, favoriteFood: "Pizza")
]

/* Exercise 6.1 */

print(
    people.filter { $0.name.hasSuffix("e") }
)

/* Exercise 6.2 */

print(
    people.filter { $0.name.lowercased().first ==  $0.name.last }
)

/* Exercise 6.3 */

print(
    people.filter { $0.age < 18 }.map { $0.name }
)

/* Exercise 6.4 */

print(
    // max returns nil if the array is empty.
    // We know for sure it's not, so we can safely force-unwrap the optional.
    people.map { $0.age }.max()!
)

print(
    // We can use reduce's first parameter to store the largest age so far as we process each element.
    people.reduce(0) { $1.age > $0 ? $1.age : $0 }
)

/* Exercise 6.5 */

print(
    // We can use reduce to build the average age as we process each element.
    people.reduce(0.0) { $0 + Double($1.age) / Double(people.count) }
    // Alternatively, we could use reduce to first find the total age,
    // then divide this by the number of people.
)

/* Exercise 6.6 */

people.sort { $0.age < $1.age }

/* Exercise 6.7 */

if let index = people.firstIndex(where: { $0.name == "Charlie" }) {
    print("Charlie is at index \(index).")
}

/* Exercise 6.8 */

print(
    // We know at least one person has pizza as their favorite food,
    // so we can safely force-unwrap the optional returned by first.
    people.filter { $0.favoriteFood == "Pizza" }.first!
)

print(
    people.first { $0.favoriteFood == "Pizza" }!
)

// The solution that uses `first(where:)` performs best because it can stop when it finds a match.
// The solution that uses `filter` needs to filter the entire array first, which is less efficient.

/* Exercise 6.9 */

let pizzaLovers = people.filter { $0.favoriteFood == "Pizza" }.map { $0.name }
let names = pizzaLovers.reduce("") { (text, name) in
    switch name {
    case pizzaLovers.first:
        name
    case pizzaLovers.last where pizzaLovers.count == 2:
        "\(text) and \(name)"
    case pizzaLovers.last:
        // Gotta have that Oxford comma ;)
        "\(text), and \(name)"
    default:
        "\(text), \(name)"
    }
}
switch pizzaLovers.count {
case 0:
    print("No one loves pizza.")
case 1:
    print("\(names) loves pizza.")
default:
    print("\(names) love pizza.")
}

/* Exercise 6.10 */

print(
    people.compactMap { $0.favoriteFood }
)

/* Exercise 6.11 */

var favoriteFoods: [String: Int] = [:]
people.compactMap { $0.favoriteFood }.forEach {
    favoriteFoods[$0, default: 0] += 1
}
print(favoriteFoods)
