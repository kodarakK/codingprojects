// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "exercises-6",
    targets: [
        .executableTarget(
            name: "exercises-6",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
