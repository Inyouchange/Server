// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "1005",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "1005",
            targets: ["1005"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.0.0"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
        .package(url: "https://github.com/IBM-Swift/LoggerAPI.git", from: "1.7.3"),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery-ORM.git", from: "0.3.1"),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL.git", from: "1.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "App",
            dependencies: ["Kitura", "SwiftKueryPostgreSQL",
                           "LoggerAPI", "HeliumLogger", "SwiftKueryORM"]),
        .testTarget(
            name: "1005Tests",
            dependencies: ["1005"]),
    ]
)
