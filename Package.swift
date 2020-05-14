// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "LustapoWorker",
    products: [
        .library(
            name: "LustapoWorker",
            targets: ["LustapoWorker"])
    ],
    targets: [
        .target(
            name: "Run",
            dependencies: ["LustapoWorker"]),
        .target(
            name: "LustapoWorker",
            dependencies: []),
        .testTarget(
            name: "LustapoWorkerTests",
            dependencies: ["LustapoWorker"])
    ]
)
