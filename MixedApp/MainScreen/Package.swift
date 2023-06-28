// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MainScreen",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "MainScreen",
            targets: ["MainScreen"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Coordinator", path: "../Coordinator"),
        .package(name: "UIComponents", path: "../UIComponents"),
        .package(name: "Detail", path: "../Detail"),
        .package(name: "List", path: "../List"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "MainScreen",
            dependencies: [
                "Core",
                "Coordinator",
                "UIComponents",
                "List",
                "Detail",
                "SDWebImageSwiftUI",
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MainScreenTests",
            dependencies: ["MainScreen"]
        ),
    ]
)
