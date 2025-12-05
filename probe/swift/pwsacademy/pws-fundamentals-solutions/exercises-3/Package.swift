// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "exercises-3",
    targets: [
        .executableTarget(
            name: "exercises-3",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
