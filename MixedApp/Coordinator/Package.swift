// swift-tools-version:5.3

import PackageDescription

// swiftlint:disable prefixed_toplevel_constant
let package = Package(
    name: "Coordinator",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "Coordinator",
            type: .dynamic,
            targets: ["Coordinator"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Coordinator",
            dependencies: []
        ),
        .testTarget(
            name: "CoordinatorTests",
            dependencies: ["Coordinator"]
        ),
    ]
)
// swiftlint:enable prefixed_toplevel_constant
