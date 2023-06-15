// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Models",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [
        .library(name: "Protocols", targets: ["Protocols"])
    ],
    targets: [
        .target(
            name: "Protocols"),
        .testTarget(
            name: "ProtocolsTests",
            dependencies: ["Protocols"]),
    ]
)
