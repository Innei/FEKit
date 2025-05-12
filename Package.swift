// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FEKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FEKit",
            targets: ["FEKit"])
    ],
    dependencies: [
        // No external dependencies for now
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FEKit",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .unsafeFlags(
                    ["-Xfrontend", "-warn-long-function-bodies=100"], .when(configuration: .debug)),
            ]),
        .testTarget(
            name: "FEKitTests",
            dependencies: ["FEKit"]
        ),
    ]
)
