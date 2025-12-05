// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "yahtzee",
    targets: [
        .executableTarget(
            name: "yahtzee",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        )
    ]
)
