// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "exercises-7",
    targets: [
        .executableTarget(
            name: "exercises-7",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        )
    ]
)
