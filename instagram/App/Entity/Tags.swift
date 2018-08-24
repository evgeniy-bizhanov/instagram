//
//  Хранит ответы сервера по тегам
//


// MARK: - Search tag

struct TagSearchResponse: Decodable {
    let data: [TagInfo]
}

struct TagInfo: Decodable {
    let name: String
    let mediaCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case mediaCount = "media_count"
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
