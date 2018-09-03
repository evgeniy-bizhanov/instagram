//
//  Расширения типов, в т.ч. Foundation
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Array: Mappable where Element: Decodable & Encodable {}
