//
//  Выполняет запросы к профилю пользователя
//

import Alamofire

protocol ProfileService {
    
    func profile(
        token: String,
        completionHandler: @escaping (DataResponse<UserResponse>) -> Void
    )
}

/**
 Выполняет авторизацию пользователя на сервере
 */
class ProfileRequest: RequestManager, ProfileService {
    
    // MARK: - Functions
    func profile(
        token: String,
        completionHandler: @escaping (DataResponse<UserResponse>) -> Void) {
        
        let requestModel = User(baseUrl: baseUrl, token: token)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

// MARK: - Login request router
extension ProfileRequest {
    struct User: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "users/self"
        
        let token: String
        
        var parameters: Parameters? {
            return [
                "access_token": token
            ]
        }
    }
}
