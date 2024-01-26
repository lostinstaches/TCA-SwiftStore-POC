// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "Home", targets: ["Home"]),
    .library(name: "Onboarding", targets: ["Onboarding"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.0.0")
  ],
  targets: [
    .target(name: "AppFeature", dependencies: ["Home", "Onboarding"]),
    .target(name: "Onboarding", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(
      name: "Home",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ], resources: [
        .process("Resources")
      ]
    )
  ]
)
