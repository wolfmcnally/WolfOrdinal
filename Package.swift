// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WolfOrdinal",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "WolfOrdinal",
            targets: ["WolfOrdinal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/WolfMcNally/WolfBase", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "WolfOrdinal",
            dependencies: ["WolfBase"]),
        .testTarget(
            name: "WolfOrdinalTests",
            dependencies: ["WolfOrdinal"]),
    ]
)
