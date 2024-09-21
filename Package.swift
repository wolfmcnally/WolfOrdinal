// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "WolfOrdinal",
    products: [
        .library(
            name: "WolfOrdinal",
            targets: ["WolfOrdinal"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WolfOrdinal",
            dependencies: []),
        .testTarget(
            name: "WolfOrdinalTests",
            dependencies: ["WolfOrdinal"]),
    ]
)
