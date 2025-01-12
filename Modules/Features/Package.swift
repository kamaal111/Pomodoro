// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    defaultLocalization: "en",
    platforms: [.macOS(.v14), .iOS(.v18)],
    products: [
        .library(name: "PomodoroTimer", targets: ["PomodoroTimer"]),
    ],
    targets: [
        .target(name: "PomodoroTimer"),
    ]
)
