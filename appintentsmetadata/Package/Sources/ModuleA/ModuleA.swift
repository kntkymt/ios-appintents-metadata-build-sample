import AppIntents
import ModuleC

public struct AIntent: AppIntent {
    public static let title: LocalizedStringResource = "A Intent"
    public static let description = IntentDescription("A sample intent in ModuleA.")

    public init() {}

    // ModuleC の AppEntity を戻り値として使う
    public func perform() async throws -> some IntentResult & ReturnsValue<SomeEntity> {
        .result(value: SomeEntity(id: "a"))
    }
}

public struct CounterEntity: AppEntity {
    public static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Counter Entity")
    public static let defaultQuery = CounterEntityQuery()

    public var id: String

    public var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }

    public init(id: String) {
        self.id = id
    }
}

public struct CounterEntityQuery: EntityQuery {
    public init() {}

    public func entities(for identifiers: [String]) async throws -> [CounterEntity] {
        identifiers.map { CounterEntity(id: $0) }
    }
}

// 検証結果:
// AppShortcutsProvider が走査・表示されるのはバンドルルート（.app / .appex / .framework）に
// 定義した場合のみ。この ModuleA モジュールは Package 内の静的ライブラリであり、
// 独立したバンドルルートを持たないため、ここで AppShortcut を登録しても
// Siri / ショートカットアプリからは表示すらされない。
//
// （なお、複数のバンドルルートに定義した場合は表示はされるが、
//   実際に動作するのはそのうちの1つだけ。）
public struct IgnoredAppShortcuts: AppShortcutsProvider {
    public static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AIntent(),
            phrases: [
                "Run ignored first intent in \(.applicationName)",
            ],
            shortTitle: "Run Ignored First Intent",
            systemImageName: "xmark.circle"
        )
    }
}
