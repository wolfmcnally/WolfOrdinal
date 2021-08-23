// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "WolfOrdinal",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "WolfOrdinal",
            targets: ["WolfOrdinal"]),
    ],
    dependencies: [
        .package(name: "WolfBase", url: "https://github.com/WolfMcNally/WolfBase", from: "2.0.0")
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
