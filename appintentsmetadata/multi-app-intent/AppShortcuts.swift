import AppIntents
import ModuleA
import Intermediate
import LibraryKit

struct AppTargetModuleIntent: AppIntent {
    static let title: LocalizedStringResource = "AppTargetModule Intent"
    static let description = IntentDescription(
        "An intent returning an AppEntity declared in a dependency module.")

    init() {}

    // 依存モジュール側のAppEntityも使える
    func perform() async throws -> some IntentResult & ReturnsValue<CounterEntity> {
        return .result(value: CounterEntity(id: "parent"))
    }
}

struct AppTargetModuleUseDynamicLibraryEntityIntent: AppIntent {
    static let title: LocalizedStringResource = "AppTargetModule Intent which use AppEntity in DynamicLibrary"
    static let description = IntentDescription(
        "An intent returning an AppEntity declared in a dynamic library module.")

    init() {}

    // 依存モジュール側のAppEntityも使える
    func perform() async throws -> some IntentResult & ReturnsValue<LibraryKitEntity> {
        return .result(value: LibraryKitEntity(id: "parent"))
    }
}

// 検証結果:
// メインアプリ（.app）はバンドルルートなので、ここに定義した AppShortcutsProvider は
// ショートカットアプリに表示される。
//
// バンドルルート（.app / .appex / .framework）に定義した AppShortcutsProvider は
// いずれも「表示」されるが、複数のバンドルルートに定義しても実際に「動作」するのは
// そのうちの1つだけ（システムがいずれか1つのみを採用する）。
// 静的ライブラリ（Package の ModuleA など）はバンドルルートではないため、
// そこに定義した AppShortcutsProvider は表示すらされない。
// 多分バグ
struct MultiAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AppTargetModuleIntent(),
            phrases: [
                "Run parent intent in \(.applicationName)",
            ],
            shortTitle: "Run Parent Intent",
            systemImageName: "1.circle"
        )
    }
}

// このAppIntentsPackageをコメントアウトすると、LibraryKit (ダイナミックリンクライブラリ）のAppIntentやAppEntityがSiriやShortcutアプリから見つからなくなる
// 理由: アプリバンドルのMetadata.appintentsに.extract.packagedataが生成されなくなり
// SiriやShortcutアプリがLibraryKit.framework/Metadata.appintentsを探しにいかなくなるから。
//
struct MultiAppIntentsPackage: AppIntentsPackage {
    static var includedPackages: [any AppIntentsPackage.Type] {
        [
            LibraryKitAppIntentPackage.self
        ]
    }
}
