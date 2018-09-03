//
//  Мэпинг объектов через Codable
//

import Foundation

/// Экземпляры протокола могут быть сконвертированы друг в друга
public protocol Mappable: Codable {
    
    /// Выполняет мэппинг свойств одного типа на другой
    func map<TDestination: Decodable>() throws -> TDestination
}

extension Mappable {
    public func map<TDestination: Decodable>() throws -> TDestination {
        let sourcePropertyListEncoded = try PropertyListEncoder().encode(self)
        return try PropertyListDecoder().decode(TDestination.self, from: sourcePropertyListEncoded)
    }
}
