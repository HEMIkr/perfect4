import PackageDescription

let package = Package(
    name: "perfect4",
    dependencies: [
        .Package(
            url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git",
            majorVersion: 2
        )
    ]
)
