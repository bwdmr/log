// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "Log",
    platforms: [
      .macOS(.v13),
      .iOS(.v15),
      .tvOS(.v15),
      .watchOS(.v8),
    ],
    products: [ .library( name: "Log", targets: ["Log"] ) ],
    dependencies: [
      .package(url: "https://github.com/vapor/vapor.git", from: "4.106.0"),
      .package(url: "https://github.com/bwdmr/log-kit.git", branch: "main")
    ],
    targets: [
        .target(
          name: "Log",
          dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "LogKit", package: "log-kit")
          ]),
          .testTarget(
            name: "LogTests",
            dependencies: [ .target(name: "Log"), .product(name: "XCTVapor", package: "vapor") ]
        ),
    ],
    swiftLanguageModes: [ .v6 ]
)
