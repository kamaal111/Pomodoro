// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "FocusTimer", targets: ["FocusTimer"]),
        .library(name: "AppSettings", targets: ["AppSettings"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FocusTimer",
            dependencies: []),
        .target(
            name: "AppSettings",
            dependencies: []),
    ]
)
