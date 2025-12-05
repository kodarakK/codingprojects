// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "tic-tac-toe",
    targets: [
        .executableTarget(
            name: "tic-tac-toe",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
