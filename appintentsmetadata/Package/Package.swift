// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Package",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        .library(
            name: "LibraryForApp",
            targets: ["ModuleA", "Intermediate"]
        ),
        .library(
            name: "LibraryForExtension",
            targets: ["Intermediate"]
        ),
    ],
    targets: [
        .target(
            name: "ModuleA",
            dependencies: [
                "ModuleC",
            ]
        ),
        .target(
            name: "ModuleB",
            dependencies: [
                "ModuleC",
            ]
        ),
        .target(
            name: "ModuleC"
        ),
        // 空の中間モジュール
        // 中間にAppIntentsに無関係のモジュールを置いても
        // 子のAppIntentsのメタデータがアプリバンドルのメタデータに出現することを試すため
        .target(
            name: "Intermediate",
            dependencies: [
                "BookAppIntent",
                "ModuleB",
                "EmptyModule",
            ]
        ),
        // AppSchemaの挙動を見るためのモジュール
        .target(
            name: "BookAppIntent"
        ),
        // 空のモジュール。
        // appintentsmetadataprocessorはApp Intentsに無関係のモジュールのメタデータの出力をスキップする。
        // 無関係: AppIntentsを利用したコードを、そのモジュール及び依存モジュール内に持たないモジュール
        .target(
            name: "EmptyModule"
        ),
    ]
)
