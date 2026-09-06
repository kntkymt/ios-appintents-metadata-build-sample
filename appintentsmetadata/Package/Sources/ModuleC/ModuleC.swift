import AppIntents

public struct CIntent: AppIntent {
    public static let title: LocalizedStringResource = "C Intent"
    public static let description = IntentDescription("A sample intent in ModuleC.")

    public init() {}

    public func perform() async throws -> some IntentResult & ReturnsValue<SomeEntity> {
        .result(value: SomeEntity(id: "c"))
    }
}

// ModuleA / ModuleB の AppIntent が ReturnsValue として共有するエンティティ
public struct SomeEntity: AppEntity {
    public static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Some Entity")
    public static let defaultQuery = SomeEntityQuery()

    public var id: String

    public var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }

    public init(id: String) {
        self.id = id
    }
}

public struct SomeEntityQuery: EntityQuery {
    public init() {}

    public func entities(for identifiers: [String]) async throws -> [SomeEntity] {
        identifiers.map { SomeEntity(id: $0) }
    }
}
