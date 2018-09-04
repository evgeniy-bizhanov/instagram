//
//  Хранит ответы сервера по тегам
//


// MARK: - Search tag

struct TagSearchResponse: Decodable {
    let data: [TagInfo]
}

struct TagInfo: Mappable {
    let name: String
    let mediaCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case mediaCount = "media_count"
    }
    
    enum EncodingKeys: CodingKey {
        case name
        case mediaCount
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(mediaCount, forKey: .mediaCount)
    }
}


// MARK: - Tag media recent

struct TagMediaRecentResponse: Decodable {
    let data: [Media]
}


// MARK: - Tag info

struct TagInfoResponse: Decodable {
    let data: TagInfo
}
