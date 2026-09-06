protocol SomeProtocol {}

let anotherTitle = "title"
struct SomeType: SomeProtocol {
    let title1: String = anotherTitle

    var title2: String {
        let title = "title"

        return title
    }
}