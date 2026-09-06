import AppIntents
import Intermediate

struct ExtensionIntent: AppIntent {
    static let title: LocalizedStringResource = "Extension Intent"
    static let description = IntentDescription("An intent provided by an App Intents extension.")

    func perform() async throws -> some IntentResult & ProvidesDialog {
        return .result(dialog: "Pong from extension")
    }
}

// 検証結果:
// App Intents Extension はそれ自体が独立したバンドルルート（.appex）なので、
// このバンドルに定義した AppShortcutsProvider もショートカットアプリに「表示」される。
//
// ただし、複数のバンドルルート（.app / .appex / .framework）に AppShortcutsProvider を
// 定義しても、実際に「動作」するのはそのうちの1つだけ（システムがいずれか1つのみを採用する）。
struct ExtensionAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: ExtensionIntent(),
            phrases: [
                "Run extension intent in \(.applicationName)",
            ],
            shortTitle: "Run Extension Intent",
            systemImageName: "checkmark.circle"
        )
    }
}

@main
struct IntentsExtension: AppIntentsExtension {
}
