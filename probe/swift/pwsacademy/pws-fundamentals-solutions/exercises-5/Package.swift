// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "exercises-5",
    targets: [
        .executableTarget(
            name: "exercises-5",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
