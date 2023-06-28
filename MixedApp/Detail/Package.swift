// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Detail",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "Detail",
            targets: ["Detail"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Coordinator", path: "../Coordinator"),
        .package(name: "UIComponents", path: "../UIComponents"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0"),
        .package(url: "https://github.com/ReSwift/ReSwift.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "Detail",
            dependencies: [
                "Core",
                "Coordinator",
                "UIComponents",
                "SDWebImageSwiftUI",
                "ReSwift",
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "DetailTests",
            dependencies: ["Detail"]
        ),
    ]
)
