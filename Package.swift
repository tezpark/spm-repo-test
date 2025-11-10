// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestPackage",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        // Main library product
        .library(
            name: "TestPackage",
            targets: ["TestPackage"]),
        
        // Additional feature module
        .library(
            name: "TestPackageCore",
            targets: ["TestPackageCore"]),
    ],
    dependencies: [
        // External dependencies example
        // .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0"),
    ],
    targets: [
        // Main target
        .target(
            name: "TestPackage",
            dependencies: [
                "TestPackageCore"
            ],
            path: "Sources/TestPackage",
            resources: [
                .process("Resources")
            ]
        ),
        
        // Core target (shared code)
        .target(
            name: "TestPackageCore",
            dependencies: [],
            path: "Sources/TestPackageCore"
        ),
        
        // Unit tests for main target
        .testTarget(
            name: "TestPackageTests",
            dependencies: [
                "TestPackage",
                "TestPackageCore"
            ],
            path: "Tests/TestPackageTests"
        ),
        
        // Unit tests for core target
        .testTarget(
            name: "TestPackageCoreTests",
            dependencies: ["TestPackageCore"],
            path: "Tests/TestPackageCoreTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
