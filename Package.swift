// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FontConfig",
    products: [
        .library(
            name: "FontConfig",
            targets: ["FontConfig"]
        ),
    ],
    targets: [
        .target(
            name: "FontConfig",
            dependencies: [
                "CFontConfig"
            ]
        ),
        .systemLibrary(
            name: "CFontConfig",
            pkgConfig: "fontconfig",
            providers: [
                .brew(["fontconfig"]),
                .apt(["libfontconfig-dev"])
            ]
        ),
        .testTarget(
            name: "FontConfigTests",
            dependencies: ["FontConfig"]
        ),
    ]
)
