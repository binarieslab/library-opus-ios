// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let platforms: [SupportedPlatform] = [
    .macOS(.v11), .iOS(.v13), .watchOS(.v6)
]
let products: [Product] = [
    .library(name: "BLOpus", targets: ["BLOpus", "OpusSwift"])
]
let testResources: [Resource] = [
    .copy("Resources/audiosample.mp3")
]
let targets: [Target] = [
    .target(name: "BLOpus", dependencies: []),
    .binaryTarget(name: "OpusSwift", path: "Framework/OpusSwift.xcframework"),
    .testTarget(name: "BLOpusTests", dependencies: ["BLOpus"], resources: testResources)
]
let package = Package(
    name: "BLOpus",
    platforms: platforms,
    products: products,
    targets: targets
)
