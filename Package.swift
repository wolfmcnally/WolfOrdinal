// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "WolfOrdinal",
    products: [
        .library(
            name: "WolfOrdinal",
            targets: ["WolfOrdinal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/WolfMcNally/WolfBase", from: "6.0.0")
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
