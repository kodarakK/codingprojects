// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "exercises-4",
    targets: [
        .executableTarget(
            name: "exercises-4",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
