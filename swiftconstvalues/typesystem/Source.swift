// ConstExtract が「テキストマッチ」ではなく「型システム(Sema の解決結果)」で
// 動いていることを示すデモ。
// protocols.json には ["ConstConfig"] しか書いていないが、以下の型はすべて抽出される。
// ソース上に "ConstConfig" と書いていない型が抽出されるのがポイント。

protocol ConstConfig {}

// 1. 子 protocol への準拠 — 継承チェーンを辿って ConstConfig 適合と判定される
protocol FeatureConfig: ConstConfig {}

struct ChildProtocolConformer: FeatureConfig {
    let name = "via-child-protocol"
}

// 2. protocol の typealias への準拠 — エイリアスが解決されて ConstConfig 適合と判定される
typealias ConfigAlias = ConstConfig

struct AliasConformer: ConfigAlias {
    let name = "via-protocol-typealias"
}

// 3. extension での準拠 — 型宣言と離れた場所の適合も conformance テーブルで見つかる
struct ExtensionConformer {
    let name = "via-extension"
}

extension ExtensionConformer: ConstConfig {}

// 4. 変数の型が String の typealias — 型表現がどう記録されるかに注目
typealias UserID = String

struct AliasedFieldType: ConstConfig {
    let id: UserID = "user-123"
    let plain: String = "for-comparison"
}
