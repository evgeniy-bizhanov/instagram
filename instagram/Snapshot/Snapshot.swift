//
//  Протокол состояния моделей
//

protocol Snapshot: Codable {
    var id: String { get }
}
