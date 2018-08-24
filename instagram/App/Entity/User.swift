//
//  Хранит информацию о пользователе
//


// MARK: - User

struct UserResponse: Decodable {
    let data: User
}

struct User: Decodable {
    let id: String
    let username: String
    let fullName: String
    let profilePicture: String
    let bio: String?
    let website: String?
    let isBusiness: Bool?
    let counts: UserCounts?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case fullName = "full_name"
        case profilePicture = "profile_picture"
        case bio
        case website
        case isBusiness = "is_business"
        case counts
    }
}

struct UserCounts: Decodable {
    let media: Int
    let follows: Int
    let followedBy: Int
    
    enum CodingKeys: String, CodingKey {
        case media
        case follows
        case followedBy = "followed_by"
    }
}
