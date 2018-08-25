//
//  Хранит медиа пользователя
//

struct MediaResponse: Decodable {
    let data: [Media]?
}

struct Media: Decodable {
    let id: String?
    let user: User?
    let images: Images?
    let created: String?
    let caption: Caption?
    let hasLiked: Bool?
    let likes: Counts?
    let tags: [String]?
    let filter: String?
    let comments: Counts?
    let type: String?
    let link: String?
    let location: Location?
    let usersInPhoto: [User]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case user
        case images
        case created = "created_time"
        case caption
        case hasLiked = "user_has_liked"
        case likes
        case tags
        case filter
        case comments
        case type
        case link
        case location
        case usersInPhoto = "users_in_photo"
    }
}

struct Images: Decodable {
    let thumbnail: Image?
    let low: Image?
    let standard: Image?
    
    enum CodingKeys: String, CodingKey {
        case thumbnail
        case low = "low_resolution"
        case standard = "standard_resolution"
    }
}

struct Image: Decodable {
    let width: Int?
    let height: Int?
    let url: String?
}

struct Caption: Decodable {
    let id: String?
    let text: String?
    let created: String?
    let from: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case created = "created_time"
        case from
    }
}

struct Counts: Decodable {
    let count: Int?
}

struct Location: Decodable {
    let id: Int?
    let latitude: Double?
    let longitude: Double?
    let name: String?
}
