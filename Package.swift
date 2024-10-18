// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Vquery",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Vquery",
            targets: ["Vquery"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Vquery",
            dependencies: [],
            path: "Vquery",
            exclude: ["README.md", "LICENSE"]
        ),
        .testTarget(
            name: "VqueryTests",
            dependencies: ["Vquery"],
            path: "VqueryTests"
        ),
    ]
)
