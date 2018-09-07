//
//  Управляет состояниями моделей
//

protocol SnapshotManager {
    func snapshot<T: Snapshot>(with identifier: String) -> T?
    func save<T: Snapshot>(snapshot: T)
}
