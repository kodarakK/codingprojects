// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "exercises-1",
    targets: [
        .executableTarget(
            name: "exercises-1",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
