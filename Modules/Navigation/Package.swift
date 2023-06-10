// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kamaalio/KamaalSwift.git", "0.8.0" ..< "0.9.0"),
        .package(path: "../Models"),
        .package(path: "../Features")
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: [
                .product(name: "KamaalUI", package: "KamaalSwift"),
                .product(name: "Protocols", package: "Models"),
                .product(name: "FocusTimer", package: "Features"),
                .product(name: "AppSettings", package: "Features"),
            ]),
        .testTarget(
            name: "NavigationTests",
            dependencies: ["Navigation"]),
    ]
)
