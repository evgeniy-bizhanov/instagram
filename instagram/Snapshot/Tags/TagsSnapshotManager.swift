//
//  Управляет состояниями контроллера поиска по тегам
//

import Foundation

class TagsSnapshotManager: SnapshotManager {
    func snapshot<T: Snapshot>(with identifier: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key(for: identifier)) else {
            return nil
        }
        
        return try? PropertyListDecoder().decode(T.self, from: data)
    }
    
    func save<T: Snapshot>(snapshot: T) {
        let data = try? PropertyListEncoder().encode(snapshot)
        UserDefaults.standard.set(data, forKey: key(for: snapshot.id))
    }
    
    private func key(for identifier: String) -> String {
        return "snapshot.\(identifier)"
    }
}
