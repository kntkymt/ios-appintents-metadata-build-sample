// AppIntents フレームワークを対象にした swiftconstvalues デモ。
// Xcode が App Intents のメタデータ抽出(appintentsmetadataprocessor)で
// 使っているのと同じ protocol リスト (appintents-protocols.json) を渡す。

import AppIntents

// Assistant schema (system.search) 準拠の intent。
// @AppIntent マクロ(旧 @AssistantIntent)が title などのメタデータを生成する。
@AppIntent(schema: .system.search)
struct SearchIntent: AppIntent {
    static let searchScopes: [StringSearchScope] = [.general]

    var criteria: StringSearchCriteria

    func perform() async throws -> some IntentResult {
        .result()
    }
}

// // 素の AppIntent
struct SomeIntent: AppIntent {
    static let someStaticText = "Some Intent"

    static let title: LocalizedStringResource = "\(someStaticText)"
    static var description: IntentDescription {
        let result = IntentDescription("A plain demo intent.")

        return result
    }

    func perform() async throws -> some IntentResult {
            // do something
        return .result()
    }
}