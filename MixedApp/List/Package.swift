// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "List",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "List",
            targets: ["List"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Coordinator", path: "../Coordinator"),
        .package(name: "UIComponents", path: "../UIComponents"),
        .package(name: "Detail", path: "../Detail"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "List",
            dependencies: [
                "Core",
                "Coordinator",
                "UIComponents",
                "Detail",
                "SDWebImageSwiftUI",
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "ListTests",
            dependencies: ["List"]
        ),
    ]
)
