import PackageDescription

let package = Package(
    name: "aggregation",
    dependencies: [
        .Package(url: "https://github.com/OpenKitten/MongoKitten.git", majorVersion: 3)
    ]
)
