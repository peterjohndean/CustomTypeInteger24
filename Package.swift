// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CTInteger24",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CTInteger24",
            targets: ["CTInteger24"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CTInteger24"),
        .testTarget(
            name: "CTInteger24Tests",
            dependencies: ["CTInteger24"]
        ),
    ]
)
