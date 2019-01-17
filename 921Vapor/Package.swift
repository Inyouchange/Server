// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "921",
    /*products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "921",
            targets: ["921"]),
    ],*/
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git",from:"3.0.0"),
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vapor/fluent-postgresql.git",from:"1.0.0-rc"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "0.9.0")

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "App",
            dependencies: ["Vapor","FluentPostgreSQL","Leaf","CryptoSwift"]),
        .target(
            name: "Run",
            dependencies: ["App"])
        
        
    ]
)
