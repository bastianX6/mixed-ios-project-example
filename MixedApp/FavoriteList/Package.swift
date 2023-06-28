// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FavoriteList",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "FavoriteList",
            targets: ["FavoriteList"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Coordinator", path: "../Coordinator"),
        .package(name: "Detail", path: "../Detail"),
        .package(name: "UIComponents", path: "../UIComponents"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "FavoriteList",
            dependencies: [
                "Core",
                "Coordinator",
                "Detail",
                "UIComponents",
                "SDWebImageSwiftUI",
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "FavoriteListTests",
            dependencies: ["FavoriteList"]
        ),
    ]
)
