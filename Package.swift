// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PixelSDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "PixelSDK", targets: ["PixelSDKWrapper"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "GPUImage", url: "https://github.com/GottaYotta/GPUImage3.git", from: "3.0.0")
        //.package(name: "GPUImage", path: "/Users/joshbernfeld/Repositories/GPUImage3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "PixelSDKWrapper", dependencies: ["PixelSDK","GPUImage"], path: ".github/empty"),
        .binaryTarget(
            name: "PixelSDK",
            path: "PixelSDK.xcframework"
        )
    ]
)
