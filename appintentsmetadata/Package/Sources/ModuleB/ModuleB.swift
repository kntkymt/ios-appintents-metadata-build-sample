import AppIntents
import ModuleC

public struct BIntent: AppIntent {
    public static let title: LocalizedStringResource = "B Intent"
    public static let description = IntentDescription("A sample intent in ModuleB.")

    public init() {}

    // ModuleC の AppEntity を戻り値として使う
    public func perform() async throws -> some IntentResult & ReturnsValue<SomeEntity> {
        .result(value: SomeEntity(id: "b"))
    }
}

@AssistantIntent(schema: .system.search)
public struct TransitiveSearchIntent: ShowInAppSearchResultsIntent {
    public static let searchScopes: [StringSearchScope] = [.general]

    @Parameter
    public var criteria: StringSearchCriteria

    public init() {}

    public func perform() async throws -> some IntentResult {
        .result()
    }
}
