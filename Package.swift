// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Vquery",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "Vquery",
            targets: ["Vquery"]),
    ],
    targets: [
        .target(
            name: "Vquery",
            path: "Sources"
        ),
    ]
)
