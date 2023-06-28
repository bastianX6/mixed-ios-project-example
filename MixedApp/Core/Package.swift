// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0")),
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                "Alamofire",
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        ),
    ]
)
