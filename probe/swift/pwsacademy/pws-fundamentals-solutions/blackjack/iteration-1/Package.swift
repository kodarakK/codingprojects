// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "blackjack",
    targets: [
        .executableTarget(
            name: "blackjack",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
