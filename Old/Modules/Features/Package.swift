// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
    products: [
        .library(name: "FocusTimer", targets: ["FocusTimer"]),
        .library(name: "AppSettings", targets: ["AppSettings"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kamaalio/KamaalSwift.git", "0.8.0" ..< "0.9.0"),
    ],
    targets: [
        .target(
            name: "FocusTimer",
            dependencies: [
                .product(name: "KamaalExtensions", package: "KamaalSwift"),
//                .product(name: "KamaalLogger", package: "KamaalSwift"),
            ]),
        .target(
            name: "AppSettings",
            dependencies: []),
    ]
)
