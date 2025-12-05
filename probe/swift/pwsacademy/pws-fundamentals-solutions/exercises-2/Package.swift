// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "exercises-2",
    targets: [
        .executableTarget(
            name: "exercises-2",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
