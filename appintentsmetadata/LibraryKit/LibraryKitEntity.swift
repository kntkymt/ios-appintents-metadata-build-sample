import AppIntents

struct LibraryKitIntent: AppIntent {
    static let title: LocalizedStringResource = "Dynamic framework Intent"
    static let description = IntentDescription("An intent provided by an Dynamic framework.")

    init() {}

    func perform() async throws -> some IntentResult & ReturnsValue<LibraryKitEntity> {
        .result(value: LibraryKitEntity(id: "shelf"))
    }
}

// 検証結果:
// バンドルルート（.app / .appex / .framework）に定義した AppShortcutsProvider は
// いずれもショートカットアプリに表示される。LibraryKit は動的フレームワークの
// バンドルルートなので、ここに定義したショートカットも表示される。
//
// ただし、複数のバンドルルートに AppShortcutsProvider を定義しても、
// 実際に動作するのはそのうちの1つだけ（システムがいずれか1つのみを採用する）。
// 一方、静的ライブラリ（Package の ModuleA など）はバンドルルートでは
// ないため、そこに定義した AppShortcutsProvider は表示すらされない。
struct LibraryKitAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: LibraryKitIntent(),
            phrases: [
                "Run library kit intent in \(.applicationName)",
            ],
            shortTitle: "Run LibraryKit Intent",
            systemImageName: "checkmark.circle"
        )
    }
}

public struct LibraryKitEntity: AppEntity {
    public static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "LibraryKit Entity")
    public static let defaultQuery = LibraryKitEntityQuery()

    public var id: String

    public var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }

    public init(id: String) {
        self.id = id
    }
}

public struct LibraryKitEntityQuery: EntityQuery {
    public init() {}

    public func entities(for identifiers: [String]) async throws -> [LibraryKitEntity] {
        identifiers.map { LibraryKitEntity(id: $0) }
    }
}

public struct LibraryKitAppIntentPackage: AppIntentsPackage {}
