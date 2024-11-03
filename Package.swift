// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Vquery",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Vquery",
            targets: ["Vquery"]),
    ],
    targets: [
        .target(
            name: "Vquery",
            exclude: ["README.md", "LICENSE"]
        ),
    ]
)
